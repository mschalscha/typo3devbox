#!/bin/bash
set -e
source /pd_build/buildconfig
set -x

## ondrej with more php versions
echo deb http://ppa.launchpad.net/ondrej/php/ubuntu xenial main > /etc/apt/sources.list.d/php.list

# The recv-keys part takes a bit of time, so it's faster to receive multiple keys at once.
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys \
	E5267A6C \
  #

## NodeSource's Node.js repository
curl --fail -sL https://deb.nodesource.com/setup_4.x | bash -
