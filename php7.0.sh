#!/bin/bash
set -e
source /pd_build/buildconfig
set -x

minimal_apt_get_install --reinstall \
  php7.0 \
  php7.0-bcmath \
  php7.0-bz2 \
  php7.0-cli \
  php7.0-common \
  php7.0-curl \
  php7.0-gd \
  php7.0-gmp \
  php7.0-imap \
  php7.0-intl \
  php7.0-json \
  php7.0-mbstring \
  php7.0-mcrypt \
  php7.0-mysql \
  php7.0-pgsql \
  php7.0-pspell \
  php7.0-readline \
  php7.0-recode \
  php7.0-sqlite3 \
  php7.0-xml \
  php7.0-xmlrpc \
  php7.0-xsl \
  php7.0-zip \
  php7.0-fpm \
  php-redis \
  php-memcached \
  #

## Enable phar writing
sed -i s/';phar.readonly = On'/'phar.readonly = Off'/ /etc/php/7.0/cli/php.ini
sed -i s/';opcache.enable=0'/'opcache.enable=0'/ /etc/php/7.0/fpm/php.ini
sed -i "s|error_log = /var/log/php7.0-fpm.log|error_log = /var/log/php-fpm7.0/php-fpm7.0.log|g" /etc/php/7.0/fpm/php-fpm.conf

/pd_build/php-apcu.sh 7.0
/pd_build/php-xdebug.sh 7.0

## Enable php-fpm service
cp -a /pd_build/runit/php-fpm7.0 /etc/service/php-fpm7.0
