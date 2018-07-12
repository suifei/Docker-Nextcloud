#!/bin/bash
mkdir -p ~/nextcloud/www
mkdir -p ~/nextcloud/log
mkdir -p ~/nextcloud/apps
mkdir -p ~/nextcloud/config
mkdir -p ~/nextcloud/data
mkdir -p ~/nextcloud/mysql

sudo docker run -i -t -d -p 3306:3306 \
    --name="nc-mysql" \
    --net="bridge" \
    -e MYSQL_ROOT_PASSWORD=123 \
    -v ~/nextcloud/mysql:/var/lib/mysql \
    -v ~/nextcloud/log:/var/log \
    mysql:5.7

sudo docker run -i -t -d -p 8080:80 \
    --name="nc" \
    --net="bridge" \
    --link="nc-mysql" \
    -v ~/nextcloud/www:/var/www/html \
    -v ~/nextcloud/apps:/var/www/html/custom_apps \
    -v ~/nextcloud/config:/var/www/html/config \
    -v ~/nextcloud/data:/var/www/html/data \
    -v ~/nextcloud/log:/var/log \
    nextcloud:13.0.4-apache
    
# nextcloud db connect info: mysql-host = nc-mysql , mysql-port = 3306 , mysql-user = root , mysql-password = YourPassword
