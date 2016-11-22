#!/bin/bash
set -e
source /pd_build/buildconfig
set -x
PHP_VER=$1

# dont need php"${PHP_VER}"-dev already having this from apcu
cd /usr/local/src/
if ! [ -d "/usr/local/src/xdebug" ] ; then
    git clone https://github.com/xdebug/xdebug.git
fi
cd xdebug
phpize
./configure
make
make install
make clean

echo "zend_extension=xdebug.so" > /etc/php/"${PHP_VER}"/fpm/conf.d/20-xdebug.ini
