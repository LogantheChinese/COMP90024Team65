#!/bin/bash

func_install_dependencies() {
    echo "Starting to install dependencies on local..."
    sleep 1
    sudo apt install python3-pip -y
    sudo pip install -r requirements.txt
    ansible --version
    echo "Starting to install ansible galaxy collections..."
    ansible-galaxy collection install openstack.cloud:2.1.0
    ansible-galaxy collection install community.general
    ansible-galaxy collection install community.kubernetes

    # Download the latest release of kubespray
    echo "Downloading kubespray..."
    git clone -b release-2.21 https://github.com/kubernetes-sigs/kubespray.git ./external/kubespray
}

func_generate_ssh_key() {
    echo "Starting to generate SSH key..."

    ssh_dir="./.ssh"

    if [ ! -d "$ssh_dir" ]; then
        mkdir "$ssh_dir"
    fi

    ssh-keygen -t rsa -b 2048 -f "$ssh_dir/id_rsa" -N ""
}

func_import_rc_file() {
    read -p "Please enter the path to your OpenStack RC file: " rc_file

    # Parse the RC file and extract the variables
    OS_AUTH_URL=$(grep 'OS_AUTH_URL=' $rc_file | cut -d '=' -f 2)
    OS_USERNAME=$(grep 'OS_USERNAME=' $rc_file | cut -d '=' -f 2)
    OS_PROJECT_ID=$(grep 'OS_PROJECT_ID=' $rc_file | cut -d '=' -f 2)
    OS_PROJECT_NAME=$(grep 'OS_PROJECT_NAME=' $rc_file | cut -d '=' -f 2)
    OS_USER_DOMAIN_NAME=$(grep 'OS_USER_DOMAIN_NAME=' $rc_file | cut -d '=' -f 2)
    OS_PROJECT_DOMAIN_ID=$(grep 'OS_PROJECT_DOMAIN_ID=' $rc_file | cut -d '=' -f 2)
    OS_REGION_NAME=$(grep 'OS_REGION_NAME=' $rc_file | cut -d '=' -f 2)
    OS_INTERFACE=$(grep 'OS_INTERFACE=' $rc_file | cut -d '=' -f 2)
    OS_IDENTITY_API_VERSION=$(grep 'OS_IDENTITY_API_VERSION=' $rc_file | cut -d '=' -f 2)
    read -p "Please enter your OpenStack password: " OS_PASSWORD

    # Create a clouds.yaml file using the variables from the RC file
    cat > clouds.yaml << EOF
clouds:
  mrc:
    auth:
      auth_url: $OS_AUTH_URL
      username: $OS_USERNAME
      password: $OS_PASSWORD
      project_id: $OS_PROJECT_ID
      project_name: $OS_PROJECT_NAME
      user_domain_name: $OS_USER_DOMAIN_NAME
      project_domain_id: $OS_PROJECT_DOMAIN_ID
    region_name: $OS_REGION_NAME
    interface: $OS_INTERFACE
    identity_api_version: $OS_IDENTITY_API_VERSION
EOF
    echo "clouds.yaml has been created."
}

func_check_provision_settings() {

    cat ./vars/openstack_vars.yaml
    echo "Do you want to modify the Openstack provision settings in ./vars/openstack_vars.yaml? (y/n)"
    read -p "Your choice: " modify_choice
    if [ "$modify_choice" == "y" ]; then
        vi ./vars/openstack_vars.yaml
    fi
    
}

func_init_deploy() {

    echo "Starting the initial deployment..."

    echo "Provisioning infrastructure on MRC"
    sleep 1

    ansible-playbook create_openstack_instance.yaml
    read -p "Do you want to continue to setup node environment(yes/no)? " CONTINUE
    if [ "$CONTINUE" != "yes" ]; then
        echo "Exiting deployment..."
        exit 1
    fi
    
    echo "Provision finished. Starting to setup basic environment"
    sleep 1
    
    ansible-playbook node_environment_setup.yaml
    read -p "Do you want to continue to deploy k8s cluster(yes/no)? " CONTINUE
    if [ "$CONTINUE" != "yes" ]; then
        echo "Exiting deployment..."
        exit 1
    fi

    echo "Environment setup finished. Starting to deploy the k8s cluster..."
    sleep 1

    ansible-playbook create_kubernetes_cluster.yaml
    read -p "Do you want to continue to initialize k8s cluster environment(yes/no)? " CONTINUE
    if [ "$CONTINUE" != "yes" ]; then
        echo "Exiting deployment..."
        exit 1
    fi

    echo "Cluster deployment finished. Starting to initialize the k8s cluster environment..."
    sleep 1
    ansible-playbook cluster_environment_setup.yaml

    read -p "Do you want to continue to deploy the CouchDB(yes/no)? " CONTINUE
    if [ "$CONTINUE" != "yes" ]; then
        echo "Exiting deployment..."
        exit 1
    fi

    echo "Cluster environment setup finished. Starting to deploy the CouchDB..."
    sleep 1
    ansible-playbook cluster_couchdb_install.yaml
    
    echo "All Done! Cluster is ready to use."
}

func_scale_up_cluster() {
    echo "Starting to scale up the cluster..."
    sleep 1
    ansible-playbook scale_up_cluster.yaml
}

func_scale_up_couchdb() {
    echo "Reading the current CouchDB cluster size from ./vars/couchdb_vars.yaml..."
    echo "Your current CouchDB cluster size is: "
    cat ./vars/instance_vars.yaml | grep -E "clusterSize"
    read -p "Please input new cluster size(Number): " new_cluster_size
    sed -i "s|clusterSize: .*|clusterSize: $new_cluster_size|" ./vars/couchdb_vars.yaml
    echo "Successfully update ./vars/couchdb_vars.yaml. Your new CouchDB cluster size is: "
    cat ./vars/couchdb_vars.yaml | grep -E "clusterSize"
    read -p "Do you want to continue to scale up the CouchDB cluster(yes/no)? " CONTINUE
    if [ "$CONTINUE" != "yes" ]; then
        echo "Exiting deployment..."
        exit 1
    fi

    echo "Starting to scale up(update) the CouchDB cluster..."
    sleep 1
    ansible-playbook cluster_couchdb_install.yaml
}

func_submit_twitter_files() {
    echo "Reading the current Tweet file link from ./vars/application_twitter_vars.yaml..."
    echo "Your current Twitter file link is: "
    cat ./vars/application_twitter_vars.yaml | grep -E "twitter_download_link"
    read -p "Do you want to modify the Twitter file link(yes/no)? " CONTINUE
    if [ "$CONTINUE" = "yes" ]; then
        echo "Please input the Dropbox URL link of the Twitter file, do not contain query separator like'?'"
        echo "(Example: https://www.dropbox.com/s/r6l4ke6h858bzph/twitter-huge.json.zip)"
        read -p "Please input your Dropbox zip file URL: " twitter_file_link_new
        sed -i "s|twitter_download_link: .*|twitter_download_link: $twitter_file_link_new|" ./vars/application_twitter_vars.yaml
        echo "Successfully update ./vars/application_twitter_vars.yaml. Your new Twitter file link is: "
        cat ./vars/application_twitter_vars.yaml | grep -E "twitter_download_link"
    fi

    echo "Submitting a new Twitter file processing job to the cluster..."
    ansible-playbook application_tweet_handler.yaml

}

func_update_mastodon_harvester() {
    cat ./vars/application_mastodon_vars.yaml
    read -p "Do you want to update the Mastodon Harvester config in ./vars/application_mastodon_vars.yaml (yes/no)?" CONTINUE
    if [ "$CONTINUE" = "yes" ]; then
        vi ./vars/application_mastodon_vars.yaml
    fi
    ansible-playbook application_mastodon_harvester.yaml
    echo "Mastodon Harvester has been updated on cluster."

    
}

func_add_node() {
    echo "Starting to submit new twitter files to the cluster..."
    
}

# TODO: Work in progress

while true
do
    echo "Please choose an option:"
    echo "------------------------ [A]Basic Setup & Tools --------------------------"
    echo "1. Install dependencies on this host(ansible, openstacksdk, kubespary etc.)"
    echo "2. Generate new SSH key pair in ./.ssh/"
    echo "3. Import OpenStack RC file to generate a cloud.yaml"
    echo "4. Check or Modify the MRC Infrastructure provision settings"
    echo ""
    echo "------------------------ [B]Infrastructure Provision ---------------------"
    echo "5. Deploy the initial MRC instance, k8s cluster, and CouchDB Cluster"
    echo "6. Scale up the Cluster by adding more nodes"
    echo "7. Scale up the CouchDB cluster"
    echo ""
    echo "------------------------ [C]Application Deployment -----------------------"
    echo "8. Submit a new Twitter file processing job to the cluster via Dropbox URL"
    echo "9. Update Mastodon Harvester Target/Config on the cluster"
    echo "10. Deploy frontend and backend on the cluster"
    echo ""
    echo "0. Exit"
    read -p "Please enter your choice[0-10]: " choice

    case $choice in
        1) func_install_dependencies ;;
        2) func_generate_ssh_key ;;
        3) func_import_rc_file ;;
        4) func_check_provision_settings ;;
        5) func_init_deploy ;;
        6) func_scale_up_cluster ;;
        7) func_scale_up_couchdb ;;
        8) func_submit_twitter_files ;;

        # 5) func_init_deploy ;;
        # 6) func_submit_twitter_files ;;
        # 7) func_add_node ;;
        # 8) echo "Exiting."; break ;;
        # *) echo "Invalid option. Please input number from 1-8." ;;
    esac
done