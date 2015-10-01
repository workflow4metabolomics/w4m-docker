#!/usr/bin/env bash

yum -y install R.x86_64

yum -y install httpd.x86_64
if ! [ -L /var/www ]; then
	rm -rf /var/www
	ln -fs /vagrant /var/www
fi
