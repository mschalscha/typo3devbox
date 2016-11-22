#!/bin/bash
set -e
source /pd_build/buildconfig
set -x

apt-get update

minimal_apt_get_install --reinstall \
  php7.1 \
  php7.1-bcmath \
  php7.1-bz2 \
  php7.1-cli \
  php7.1-common \
  php7.1-curl \
  php7.1-gd \
  php7.1-gmp \
  php7.1-imap \
  php7.1-intl \
  php7.1-json \
  php7.1-mbstring \
  php7.1-mcrypt \
  php7.1-mysql \
  php7.1-pgsql \
  php7.1-pspell \
  php7.1-readline \
  php7.1-recode \
  php7.1-sqlite3 \
  php7.1-xml \
  php7.1-xmlrpc \
  php7.1-xsl \
  php7.1-zip \
  php7.1-fpm \
  php-redis \
  php-memcached \
  #

## Enable phar writing
sed -i s/';phar.readonly = On'/'phar.readonly = Off'/ /etc/php/7.1/cli/php.ini
sed -i s/';opcache.enable=0'/'opcache.enable=0'/ /etc/php/7.1/fpm/php.ini
sed -i "s|error_log = /var/log/php7.1-fpm.log|error_log = /var/log/php-fpm7.1/php7.1-fpm.log|g" /etc/php/7.0/fpm/php-fpm.conf

/pd_build/php-apcu.sh 7.1
/pd_build/php-xdebug.sh 7.1

## Enable php-fpm service
cp -a /pd_build/runit/php-fpm7.1 /etc/service/php-fpm7.1