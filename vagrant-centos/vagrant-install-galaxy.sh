#!/usr/bin/env bash

if [ -d galaxy ] ; then
	cd galaxy
	git pull
else
	git clone https://github.com/galaxyproject/galaxy
	cd galaxy
	git checkout -b master origin/master
fi
