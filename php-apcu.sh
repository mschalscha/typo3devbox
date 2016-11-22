#!/bin/bash
set -e
source /pd_build/buildconfig
set -x
PHP_VER=$1

minimal_apt_get_install \
	make \
	php"${PHP_VER}"-dev \
	#

cd /usr/local/src/
if ! [ -d "/usr/local/src/apcu" ] ; then
    git clone https://github.com/krakjoe/apcu.git
fi
cd apcu
phpize
./configure
make
make install
make clean
cd ../
if ! [ -d "/usr/local/src/apcu-bc" ] ; then
    git clone https://github.com/krakjoe/apcu-bc.git
fi
cd apcu-bc
phpize
./configure
make
make install
make clean
echo "extension=apcu.so" > /etc/php/"${PHP_VER}"/mods-available/apcu.ini
echo "apc.enable_cli=1" >> /etc/php/"${PHP_VER}"/mods-available/apcu.ini
echo "apc.slam_defense=0" >> /etc/php/"${PHP_VER}"/mods-available/apcu.ini
echo "extension=apc.so" > /etc/php/"${PHP_VER}"/mods-available/apc.ini

ln -s /etc/php/"${PHP_VER}"/mods-available/apcu.ini /etc/php/"${PHP_VER}"/cli/conf.d/20-apcu.ini

# apc-bc module must be loaded *after* apcu, have a higher integer in front to enforce this
ln -s /etc/php/"${PHP_VER}"/mods-available/apc.ini /etc/php/"${PHP_VER}"/cli/conf.d/21-apc.ini
