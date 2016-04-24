#!/bin/bash
echo "Provisioning virtual machine..."

echo "Installing Git..."
    apt-get install git -y > /dev/null
    echo "- Copying config"
    cp /vagrant/provision/config/.gitconfig /home/vagrant/.gitconfig > /dev/null
    git --version
echo "-> done"

echo "Installing Htop.."
    apt-get install htop -y > /dev/null
echo "-> done"

echo "Installing Nginx..."
    apt-get install nginx -y > /dev/null
echo "-> done"

echo "Configuring Bash..."
    cp /vagrant/provision/config/.bashrc /home/vagrant/.bashrc > /dev/null
    cp /vagrant/provision/config/.bash_aliases /home/vagrant/.bash_aliases > /dev/null
    source /vagrant/provision/config/.bashrc /home/vagrant/.bashrc > /dev/null
    mkdir -p /home/vagrant/shared > /dev/null
echo "-> done"

echo "Configuring Hosts..."
    cp /vagrant/provision/config/hosts /etc/hosts > /dev/null
echo "-> done"

echo "Configuring Nginx..."
    if [ -f /etc/nginx/sites-available/nginx_vhost ]; then
        echo "- Delete Nginx vhost"
        rm -f /etc/nginx/sites-available/nginx_vhost > /dev/null
    fi
    echo "- Create Nginx custom vhost"
    cp /vagrant/provision/config/nginx_vhost /etc/nginx/sites-available/nginx_vhost > /dev/null

    if [ -f /etc/nginx/sites-enabled/nginx_vhost ]; then
        echo "- Disable Nginx vhost"
        rm -f /etc/nginx/sites-enabled/nginx_vhost > /dev/null
    fi
    echo "- Enable Nginx custom vhost"
    ln -s /etc/nginx/sites-available/nginx_vhost /etc/nginx/sites-enabled/

    if [ -f /etc/nginx/sites-available/default ]; then
        echo "- Delete Nginx default vhost"
        rm -rf /etc/nginx/sites-available/default
        rm -f /etc/nginx/sites-enabled/default
    fi
    service nginx restart > /dev/null
echo "-> done"

echo "Installing PHP..."
    apt-get install php5-common php5-dev php5-cli php5-fpm -y > /dev/null
    php --version
echo "-> done"

echo "Installing PHP extensions..."
    apt-get install curl php5-curl php5-gd php5-mcrypt php5-mysql -y > /dev/null
echo "-> done"

echo "Preparing MySQL..."
    apt-get install debconf-utils -y > /dev/null
    debconf-set-selections <<< "mysql-server mysql-server/root_password password vagrant"
    debconf-set-selections <<< "mysql-server mysql-server/root_password_again password vagrant"
echo "-> done"

echo "Installing MySQL..."
    apt-get install mysql-server -y > /dev/null
    mysql --version
echo "-> done"

echo "Installing Curl..."
    apt-get install curl -y > /dev/null
echo "-> done"

echo "Installing Composer..."
    php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '7228c001f88bee97506740ef0888240bd8a760b046ee16db8f4095c0d8d525f2367663f22a46b48d072c816e7fe19959') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"
    mv /home/vagrant/composer.phar /usr/local/bin/composer
    composer --version
echo "-> done"

#echo "Installing projects..."
#    cd /home/vagrant/shared
#echo "-> done"
