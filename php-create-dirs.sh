#!/bin/bash
if ! [ -d "/var/run/php/" ] ; then
    mkdir -p /var/run/php/
    chmod 777 /var/run/php
fi