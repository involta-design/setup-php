#!/bin/bash

set -eo pipefail

version=$1

# Suppression to startup failure
if [ -f /lib/systemd/system/php${version}-fpm.service ]
then
    systemctl disable php${version}-fpm
fi

apt-get update

if [ $version = '5.6' ]
then
    add-apt-repository ppa:ondrej/php
    apt-fast install -y build-essential debconf-utils unzip autogen autoconf libtool pkg-config

    apt-fast install -y \
         php${version}-bcmath \
         php${version}-bz2 \
         php${version}-cgi \
         php${version}-cli \
         php${version}-common \
         php${version}-curl \
         php${version}-dba \
         php${version}-enchant \
         php${version}-gd \
         php${version}-json \
         php${version}-mbstring \
         php${version}-mysql \
         php${version}-odbc \
         php${version}-opcache \
         php${version}-pgsql \
         php${version}-readline \
         php${version}-soap \
         php${version}-sqlite3 \
         php${version}-xml \
         php${version}-xmlrpc \
         php${version}-xsl \
         php${version}-zip
fi

apt-fast install -y \
     php${version}-dev \
     php${version}-phpdbg \
     php${version}-intl \
     php${version}-xml

update-alternatives --set php /usr/bin/php${version}
update-alternatives --set phar /usr/bin/phar${version}
update-alternatives --set phpdbg /usr/bin/phpdbg${version}
phpdismod -s cli xdebug

bash -c 'echo "opcache.enable_cli=1" >> /etc/php/'$version'/cli/conf.d/10-opcache.ini'
bash -c 'echo "apc.enable_cli=1" >> /etc/php/'$version'/cli/conf.d/20-apcu.ini'
