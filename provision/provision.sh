#!/bin/bash
echo "Provisioning virtual machine..."

sudo -s

#echo "Installing Nfs..."
#  apt-get install nfs-kernel-server nfs-common -y > /dev/null
#  echo "-> Export directories..."
#  ln -s /usr/sbin/exportfs /usr/local/bin/exportfs
#  cp -f /vagrant/provision/config/exports /etc/exports > /dev/null
#  exportfs -a
#  echo "-> Restart services..."
#  service nfs-kernel-server restart
#  service nfs-common restart
#echo "-> done"

##################################################

echo "Installing Apache2..."
    apt-get install apache2 -y > /dev/null
    source /etc/apache2/envvars
    apache2 --version
    cp /vagrant/provision/config/phpinfo.php /var/www/html/phpinfo.php > /dev/null
echo "-> done"

echo "Installing PHP..."
    apt-get install php5-common php5-dev php5-cli php5-fpm libapache2-mod-php5 -y > /dev/null
    apt-get install curl php5-curl php5-gd php5-mcrypt php5-mysql -y > /dev/null
    php --version
echo "-> done"

echo "Restarting Apache2..."
    service apache2 restart > /dev/null
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

##################################################

echo "Installing htop.."
    apt-get install htop -y > /dev/null
echo "-> done"

echo "Configuring Bash..."
    cp -f /vagrant/provision/config/.bashrc /home/vagrant/.bashrc > /dev/null
    cp -f /vagrant/provision/config/.bash_aliases /home/vagrant/.bash_aliases > /dev/null
    source /home/vagrant/.bashrc > /dev/null
echo "-> done"

echo "Installing Git..."
    apt-get install git -y > /dev/null
    echo "- Copying config"
    cp /vagrant/provision/config/.gitconfig /home/vagrant/.gitconfig > /dev/null
    git --version
echo "-> done"

echo "Installing Curl..."
    apt-get install curl -y > /dev/null
echo "-> done"

echo "Installing Composer..."
    curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
    composer --version
echo "-> done"

#echo "Installing projects..."
#    cd /home/vagrant/shared
#echo "-> done"
