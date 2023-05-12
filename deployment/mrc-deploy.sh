#!/bin/bash

# Install dependencies
func_install_dependencies() {
    echo "Starting to install dependencies..."
    sleep 1
    apt install python3-pip -y
    pip install ansible openstacksdk
    ansible --version
    ansible-galaxy collection install openstack.cloud
}

func_generate_ssh_key() {
    echo "Starting to generate SSH key..."

    ssh_dir="./.ssh"

    if [ ! -d "$ssh_dir" ]; then
        mkdir "$ssh_dir"
    fi

    ssh-keygen -t rsa -b 4096 -f "$ssh_dir/id_rsa" -N ""
}

func_init_deploy() {
    echo "Starting the initial deployment..."

}

func_add_node() {
    echo "Starting to add more nodes to the existing cluster..."

}

func_submit_twitter_files() {
    echo "Starting to submit new twitter files to the cluster..."

}

# 显示选项并获取用户输入
echo "Please choose an option:"
echo "1. Install dependencies"
echo "2. Generate new SSH key pair in ./.ssh/"
echo "3. Start initial deployment"
echo "4. Add more nodes to the existing cluster"
echo "5. Submit new twitter files to the cluster"
read -p "Enter your choice: " choice

# 根据用户输入调用相应的函数
case $choice in
    1) func_install_dependencies ;;
    2) func_generate_ssh_key ;;
    3) func_init_deploy ;;
    4) func_add_node ;;
    5) func_submit_twitter_files ;;
    *) echo "Invalid option. Please input number from 1-5." ;;
esac
