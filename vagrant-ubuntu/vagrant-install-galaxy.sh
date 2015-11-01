#!/usr/bin/env bash

# Install or update Galaxy
if [ -d galaxy ] ; then

	# Update Galaxy
	cd galaxy
	git pull

else

	# Install Galaxy
	git clone https://github.com/galaxyproject/galaxy
	cd galaxy
	git checkout -b release_15.10 origin/release_15.10

	# Write .ini
	cp /vagrant/galaxy.ini config/.
fi


# Run Galaxy
./run.sh --daemon


		