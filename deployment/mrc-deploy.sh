#!/bin/bash

# Install dependencies
func_install_dependencies() {
    echo "Starting to install dependencies..."
    sleep 1
    apt install python3-pip -y
    pip install "ansible>=2.9" "openstacksdk>=1.0.0"
    ansible --version
    ansible-galaxy collection install openstack.cloud:2.1.0
}

func_generate_ssh_key() {
    echo "Starting to generate SSH key..."

    ssh_dir="./.ssh"

    if [ ! -d "$ssh_dir" ]; then
        mkdir "$ssh_dir"
    fi

    ssh-keygen -t rsa -b 2048 -f "$ssh_dir/id_rsa" -N ""
}

func_init_deploy() {
    echo "Starting the initial deployment..."

    read -p "Enter the number of master nodes (default 1): " master_node_count
    read -p "Enter the number of worker nodes (default 1): " worker_node_count
    read -p "Enter the instance type (default m3.medium): " node_instance_type
    read -p "Enter the volume size (default 250G): " node_volume_size

    # If variables are empty, assign default values
    master_node_count=${master_node_count:-1}
    worker_node_count=${worker_node_count:-1}
    node_instance_type=${node_instance_type:-m3.medium}
    node_volume_size=${node_volume_size:-250}

    # Call the ansible-playbook command with the variables
    ansible-playbook playbook.yaml \
      -e master_node_count=$master_node_count \
      -e worker_node_count=$worker_node_count \
      -e node_instance_type=$node_instance_type \
      -e node_volume_size=$node_volume_size

}

func_add_node() {
    echo "Starting to add more nodes to the existing cluster..."

}

func_submit_twitter_files() {
    echo "Starting to submit new twitter files to the cluster..."

}

# TODO: Work in progress
echo "Please choose an option:"
echo "--------------------Basic Setup & Tools--------------------"
echo "1. Install dependencies on deployment host(ansible, openstacksdk, etc.)"
echo "2. Generate new SSH key pair in ./.ssh/"
echo "3. Congigure the cluster variables(Default value is 1 Master, 1 Worker, m3.medium, 250G)"
echo "4. Configure the clouds.yaml with your openstack rc file"
echo "--------------------Deployment--------------------"
echo "4. Start initial deployment"
echo "5. Add more nodes to the existing cluster"
echo "6. Submit new twitter files to the cluster"
read -p "Enter your choice: " choice

case $choice in
    1) func_install_dependencies ;;
    2) func_generate_ssh_key ;;
    3) func_init_deploy ;;
    4) func_add_node ;;
    5) func_submit_twitter_files ;;
    *) echo "Invalid option. Please input number from 1-5." ;;
esac
