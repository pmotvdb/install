yum update -y
yum install epel-release -y
yum install htop atop iotop yum-utils wget nano whois mlocate -y
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
yum update -y
yum-config-manager --enable remi-php70 -y
yum install openssl openssl-devel gcc make gcc-c++ libXpm-devel libedit-devel enchant-devel libtidy-devel libzip-devel libxml2-devel gd-devel libzip5 libmcrypt-devel libc-client gd-last enca httpd httpd-devel autoconf automake -y
yum install -y php-composer-ca-bundle
yum install php php-pear -y
yum --disablerepo=* --enablerepo=remi-php70 
yum install -y php php-PsrLog php-bcmath php-brotli php-cli php-common php-composer-ca-bundle php-composer-semver php-composer-spdx-licenses php-composer-xdebug-handler php-devel php-enchant php-fedora-autoloader php-fpm php-gd php-gmp php-google-recaptcha php-imap php-intl php-ioncube-loader php-json php-jsonlint php-justinrainbow-json-schema5 php-mbstring php-mcrypt php-mysqlnd php-paragonie-random-compat php-password-compat php-pdo php-pear php-pecl-zip php-phpmyadmin-motranslator php-phpmyadmin-shapefile php-phpmyadmin-sql-parser php-phpseclib php-process php-psr-container php-recode php-seld-phar-utils php-soap php-symfony-browser-kit php-symfony-class-loader php-symfony-common php-symfony-config php-symfony-console php-symfony-css-selector php-symfony-debug php-symfony-dependency-injection php-symfony-dom-crawler php-symfony-event-dispatcher php-symfony-expression-language php-symfony-filesystem php-symfony-finder php-symfony-http-foundation php-symfony-http-kernel php-symfony-polyfill php-symfony-process php-symfony-var-dumper php-symfony-yaml php-symfony3-common php-symfony3-translation php-tidy php-xml php-xmlrpc phpMyAdmin
yum install -y php-pecl-imagick

yum install -y php-twig php-twig-extensions 

mkdir /home/public_html
chmod 755 /home/public_html


rm -f /etc/sysconfig/selinux
rm -f /etc/selinux/config
wget https://raw.githubusercontent.com/armpdq/configs/master/selinux -O /etc/sysconfig/selinux
wget https://raw.githubusercontent.com/armpdq/configs/master/selinux -O /etc/selinux/config
setenforce 0
wget https://raw.githubusercontent.com/armpdq/configs/master/limits.conf -O /etc/security/limits.conf
wget https://raw.githubusercontent.com/armpdq/configs/master/nginx.repo -O /etc/yum.repos.d/nginx.repo
yum install nginx nginx-module-geoip certbot python2-certbot-nginx -y


sed -i 's/apache/a
rm -f /etc/php-fpm.d/www.conf
wget https://raw.githubusercontent.com/armpdq/configs/master/php-fpm/www-land.conf -O /etc/php-fpm.d/www.conf
rm -f /etc/nginx/nginx.conf
wget https://raw.githubusercontent.com/armpdq/configs/master/nginx-t.conf -O /etc/nginx/nginx.conf
rm -f /etc/nginx/conf.d/default.conf
mkdir -p /usr/share/nginx/modules/
mkdir -p /var/lib/nginx/tmp/cache
chown -R nginx /var/lib/nginx/
wget https://raw.githubusercontent.com/armpdq/configs/master/mod-http-geoip.conf -O /usr/share/nginx/modules/mod-http-geoip.conf
wget https://sendy.acn.am/GeoIP.dat -O /usr/share/GeoIP/GeoIP-initial.dat
wget https://raw.githubusercontent.com/armpdq/configs/master/www-hem.conf -O /etc/nginx/conf.d/www.conf
wget https://raw.githubusercontent.com/armpdq/configs/master/phpstatus.conf -O /etc/nginx/phpstatus.conf
wget https://raw.githubusercontent.com/armpdq/configs/master/origin.conf -O /etc/nginx/origin.conf
systemctl daemon-reload
systemctl enable nginx
systemctl enable php-fpm
systemctl start nginx
systemctl disable rpcbind.service rpcbind.socket postfix
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer
echo "done"
