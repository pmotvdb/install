mkdir /home/public_html/
yum update -y
yum -y install epel-release
yum -y install yum-utils wget nano screen net-tools nload zip unzip htop iotop lshw smartmontools hdparm cpuid dsniff nslookup iperf3 sysstat

yum -y groupinstall 'Development Tools'
ifconfig
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
setenforce 0

yum -y install firewalld
systemctl enable firewalld.service
systemctl start firewalld.service
firewall-cmd --permanent --zone=public --add-service=http

firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --permanent --zone=public --add-service=mysql
firewall-cmd --permanent --add-service=ntp
firewall-cmd --permanent --zone=public --add-port=9749/tcp
firewall-cmd --reload


cd /etc/yum.repos.d/ && wget https://c.juicyrepo.sh/mariadb-juicycodes.repo
cd ~ && yum -y install MariaDB-server MariaDB-client
systemctl enable mariadb.service
systemctl start mariadb.service
mysql_secure_installation
cd /etc/yum.repos.d/ && wget https://c.juicyrepo.sh/nginx-juicycodes.repo
cd ~ && yum -y --disablerepo=epel --enablerepo=nginx install nginx

systemctl enable nginx.service
systemctl start nginx.service
yum -y install geoip geoip-devel

yum -y --disablerepo=epel --enablerepo=nginx install nginx-module-geoip nginx-module-geoip-debuginfo

rpm -Uvh https://rpms.remirepo.net/enterprise/remi-release-7.rpm; yum -y update; yum-config-manager --enable remi-php70; yum -y install php php-fpm php-common php-cli php-devel php-pear php-pdo php-mysqlnd php-gd php-mbstring php-mcrypt php-xml php-xmlrpc php-soap php-intl php-enchant php-bcmath php-tidy php-pecl-imagick php-recode php-imap php-twig php-json php-pecl-zip php-ioncube-loader php-brotli; chown -R nginx:nginx /var/lib/php/session; systemctl enable php-fpm.service; systemctl start php-fpm.service

rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum --enablerepo=remi,remi-test  -y install phpMyAdmin
ln -s /usr/share/phpMyAdmin /home/public_html/jcmin
chown -R nginx:nginx /etc/phpMyAdmin/
chown -R nginx:nginx /var/lib/phpMyAdmin/temp/
chown -R nginx:nginx /var/lib/phpMyAdmin/upload/
wget --no-check-certificate https://raw.githubusercontent.com/skurudo/phpmyadmin-fixer/master/pma-centos.sh && chmod +x pma-centos.sh && ./pma-centos.sh
cd /usr/share/phpMyAdmin/themes/ && wget --no-check-certificate https://files.phpmyadmin.net/themes/fallen/0.7/fallen-0.7.zip && unzip fallen-0.7.zip && rm -rf fallen-0.7.zip
nano /etc/phpMyAdmin/config.inc.php

cd / && wget -q https://c.juicyrepo.sh/proxy-confs.zip && unzip proxy-confs.zip && rm -f proxy-confs* 
cd ~ && wget -qO- https://c.juicyrepo.sh/maxmind.sh | bash
