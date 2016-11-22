#!/bin/bash
set -e
source /pd_build/buildconfig
set -x

/pd_build/enable_repos.sh
/pd_build/prepare.sh
/pd_build/nginx.sh
/pd_build/mysql.sh
/pd_build/redis-server.sh
/pd_build/memcached.sh
/pd_build/nodejs.sh
/pd_build/php7.0.sh
/pd_build/php7.1.sh
/pd_build/php-create-dirs.sh
/pd_build/php-finalize.sh
/pd_build/finalize.sh
