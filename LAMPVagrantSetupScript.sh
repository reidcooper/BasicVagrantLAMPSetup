#!/bin/bash

# Very basic LAMP set up to be used with vagrant ubuntu trusty
# Tweak as needed!
# Created by Reid Cooper
# reid.cooper8@gmail.com

# Variables
# user: root
DBPASSWD=password
echo "========================="
echo $'\n'"Running..."$'\n'
echo "========================="

echo $'\n'"Update Packages & Installing expect"$'\n'
sudo apt-get update
sudo apt-get -y install expect
echo "========================="

echo $'\n'"Installing Apache2"$'\n'
sudo apt-get -y install apache2
echo "========================="

echo $'\n'"Installing MySQL"$'\n'
echo "mysql-server mysql-server/root_password password $DBPASSWD" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $DBPASSWD" | sudo debconf-set-selections

sudo apt-get -y install mysql-server libapache2-mod-auth-mysql php5-mysql
echo "========================="

echo $'\n'"Activite MySQL"$'\n'
sudo mysql_install_db
echo "========================="

echo $'\n'"Finishing up MySQL"$'\n'

SECURE_MYSQL=$(expect -c "

set timeout 10
spawn /usr/bin/mysql_secure_installation

expect \"Enter current password for root (enter for none):\"
send \"$DBPASSWD\r\"

expect \"Change the root password?\"
send \"n\r\"

expect \"Remove anonymous users?\"
send \"y\r\"

expect \"Disallow root login remotely?\"
send \"y\r\"

expect \"Remove test database and access to it?\"
send \"y\r\"

expect \"Reload privilege tables now?\"
send \"y\r\"

expect eof
")
 
sudo echo "$SECURE_MYSQL"

echo $'\n'"Finished MySQL"$'\n'
echo "========================="

echo $'\n'"Installing PHP"$'\n'
sudo apt-get -y install php5 libapache2-mod-php5 php5-mcrypt
echo "========================="

echo $'\n'"Moving info.php"$'\n'
sudo echo "<?php phpinfo(); ?>" | sudo tee -a /var/www/html/info.php
echo "========================="

echo $'\n'"Restarting Apache2"$'\n'
sudo service apache2 restart
echo "========================="

echo $'\n'"Installing phpmyadmin"$'\n'
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password $DBPASSWD" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password $DBPASSWD" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password $DBPASSWD" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none" | sudo debconf-set-selections
sudo apt-get -y install phpmyadmin
sudo php5enmod mcrypt
echo "========================="

echo $'\n'"Restarting Apache2"$'\n'
sudo service apache2 restart
echo "========================="

echo $'\n'"Creating Symlinks"$'\n'
sudo ln -s /vagrant/ /var/www/html/vagrant
echo "========================="

echo ""$'\n'
ifconfig eth0 | grep inet | awk '{ print $2 }'
echo ""$'\n'
echo "========================="

echo $'\n'"Finished :)"$'\n'
