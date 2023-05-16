#!/bin/bash

# func_init_deploy() {
#     echo "Starting the initial deployment..."

#     read -p "Enter the number of master nodes (default 1): " master_node_count
#     read -p "Enter the number of worker nodes (default 1): " worker_node_count
#     read -p "Enter the instance type (default m3.medium): " node_instance_type
#     read -p "Enter the volume size (default 250G): " node_volume_size

#     # If variables are empty, assign default values
#     master_node_count=${master_node_count:-1}
#     worker_node_count=${worker_node_count:-1}
#     node_instance_type=${node_instance_type:-m3.medium}
#     node_volume_size=${node_volume_size:-250}

#     # Call the ansible-playbook command with the variables
#     ansible-playbook playbook.yaml \
#       -e master_node_count=$master_node_count \
#       -e worker_node_count=$worker_node_count \
#       -e node_instance_type=$node_instance_type \
#       -e node_volume_size=$node_volume_size

# }


func_install_dependencies() {
    echo "Starting to install dependencies on local..."
    sleep 1
    apt install python3-pip -y
    pip install -r requirements.txt
    ansible --version
    echo "Starting to install ansible galaxy collections..."
    ansible-galaxy collection install openstack.cloud:2.1.0
    ansible-galaxy collection install community.general

    # Download the latest release of kubespray
    echo "Downloading kubespray..."
    wget -i https://github.com/kubernetes-sigs/kubespray/archive/refs/tags/v2.21.0.tar.gz -O kubespray.tar.gz

    # Extract the downloaded file into the ./external directory
    echo "Extracting kubespray.tar.gz..."
    mkdir -p ./external
    tar -xzf kubespray.tar.gz -C ./external
    mv ./external/kubespray-* ./external/kubespray
    rm kubespray.tar.gz
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

    ansible-playbook create-openstack-instance.yaml

    echo "Provision finished. Starting to deploy the cluster..."
    sleep 1

    ansible-playbook create-kubernetes-cluster.yaml
    
    echo "Cluster deployment finished. Starting to deploy the applications..."
}

func_submit_twitter_files() {
    echo "Submitting Twitter files..."
    
}

func_add_node() {
    echo "Starting to submit new twitter files to the cluster..."
    
}

# TODO: Work in progress

while true
do
    echo "Please choose an option:"
    echo "-------------------- [A]Basic Setup & Tools --------------------"
    echo "1. Install dependencies on this host(ansible, openstacksdk, kubespary etc.)"
    echo "2. Generate new SSH key pair in ./.ssh/"
    echo "3. Import OpenStack RC file to cloud.yaml"
    echo "4. Check&Modify the MRC OpenStack provision settings\n"
    echo "-------------------- [B]Initial Deployment --------------------"
    echo "5. Deploy the initial MRC cluster and applications\n"
    echo "-------------------- [C]Other Tools --------------------"
    echo "6. Submit a new Twitter file processing job to the cluster"
    echo "7. Add more nodes to the existing cluster"
    echo "8. Exit"
    read -p "Please enter your choice[1-8]: " choice

    case $choice in
        1) func_install_dependencies ;;
        2) func_generate_ssh_key ;;
        3) func_import_rc_file ;;
        4) func_check_provision_settings ;;
        5) func_init_deploy ;;
        6) func_submit_twitter_files ;;
        7) func_add_node ;;
        8) echo "Exiting."; break ;;
        *) echo "Invalid option. Please input number from 1-8." ;;
    esac
done