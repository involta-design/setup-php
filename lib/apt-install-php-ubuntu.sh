#!/bin/bash

set -eo pipefail

version=$1

# Suppression to startup failure
if [ -f /lib/systemd/system/php${version}-fpm.service ]
then
    systemctl disable php${version}-fpm
fi

add-apt-repository ppa:apt-fast/stable

apt-get update
apt-get install apt-fast

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
