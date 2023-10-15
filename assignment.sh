#!/bin/bash

# ssh into master and create a user named altschool and assign it super user privileges create a file in a directory and copy into thesame directo
# on slave node.. this should be performed from the master node 

# The Master node should display an overview of the Linux process management, showcasing currently running processes.
# Vagrant box names for Ubuntu

MASTER_BOX="ubuntu/bionic64"
SLAVE_BOX="ubuntu/bionic64"


# Function to create and configure the Vagrant environment
create_vagrant_environment() {
  # Initialize the Vagrant environment
  vagrant init

  # Update the Vagrantfile for the 'Master' node
  cat <<EOF > Vagrantfile
Vagrant.configure("2") do |config|
  config.vm.define "master" do |subconfig|
    subconfig.vm.box = "$MASTER_BOX"
    subconfig.vm.hostname = "master"
    subconfig.vm.network "private_network", type: "static", ip: "192.168.56.10"
    subconfig.vm.provision "shell", path: "master.sh"
  end

  config.vm.define "slave" do |subconfig|
    subconfig.vm.box = "$SLAVE_BOX"
    subconfig.vm.hostname = "slave"
    subconfig.vm.network "private_network", type: "static", ip: "192.168.56.11"
  end

  #Provisioning script
  config.vm.provision "shell", path: "script.sh"
end
EOF
  # Create and provision the nodes
  vagrant up
}

create_vagrant_environment

vagrant ssh master


# Output instructions to SSH into the 'Slave' node
echo "You can SSH into the 'Slave' node using 'vagrant ssh slave' after provisioning."


