#!/bin/bash
set -e
source /pd_build/buildconfig
set -x

minimal_apt_get_install \
  nginx \
  #

rm -f /etc/nginx/sites-enabled/default

## Configure NGINX
#cp /pd_build/config/nginx/nginx.conf /etc/nginx/nginx.conf
#cp /pd_build/config/nginx/upstream-acceptance-tests.conf /etc/nginx/conf.d/
#cp /pd_build/config/nginx-sites/* /etc/nginx/sites-enabled/

## Additional config files
cp -r /pd_build/config/nginx/* /etc/nginx/.
mkdir /srv/www
cp /pd_build/resources/* /srv/www/.
## Enable nginx daemon
cp -a /pd_build/runit/nginx /etc/service/nginx