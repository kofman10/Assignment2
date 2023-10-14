#!/bin/bash

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
    subconfig.vm.hostname = "masters"
    subconfig.vm.network "private_network", type: "dhcp"
  end

  config.vm.define "slave" do |subconfig|
    subconfig.vm.box = "$SLAVE_BOX"
    subconfig.vm.hostname = "slave"
    subconfig.vm.network "private_network", type: "dhcp"
  end

  #Provisioning script
  config.vm.provision "shell", path: "script.sh"
end
EOF
  # Create and provision the nodes
  vagrant up
}

create_vagrant_environment

# Output instructions to SSH into the 'Slave' node
echo "You can SSH into the 'Slave' node using 'vagrant ssh slave' after provisioning."


