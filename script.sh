 #!/bin/bash

# install LAMPSTACK on both sides
# Ensure Apache is running and set to start on boot.
# Secure the MySQL installation and initialize it with a default user and password.
# Validate PHP functionality with Apache.

# ssh into master and create a user named altschool and assign it super user privileges create a file in a directory and copy into thesame directo
# on slave node.. this should be performed from the master node 

# The Master node should display an overview of the Linux process management, showcasing currently running processes.
mysql_root_password="password"

function install_lamp_stack {
    # Install LAMP Stack
    sudo apt-get update
    sudo apt-get install -y apache2 mysql-server php8.1 libapache2-mod-php 
    sudo systemctl enable apache2
    sudo systemctl start apache2
    sudo mysql_secure_installation 
}

# Install LAMP stack on both sides
install_lamp_stack
echo "lamp stack installed"
    sudo mysql -u root -p$mysql_root_password -e "CREATE USER 'myuser'@'localhost' IDENTIFIED BY 'mypassword';"

# Test PHP functionality
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php

echo "LAMP stack installed. You can access PHP info at http://localhost/info.php"

# allow machines to communicate with themselves via hostname
sudo apt install -y avahi-daemon libnss-mdns

echo "machines can now talk to themselves on to the next ....."
