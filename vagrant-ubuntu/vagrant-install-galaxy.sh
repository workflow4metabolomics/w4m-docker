#!/usr/bin/env bash

# Install or update Galaxy
if [ -d galaxy ] ; then

	# Update Galaxy
	cd galaxy
	git pull
	cd ..

else

	# Install Galaxy
	git clone https://github.com/galaxyproject/galaxy
	cd galaxy
	git checkout -b release_15.10 origin/release_15.10

	# Write .ini
	cp /vagrant/galaxy.ini config/.

	cd ..
fi

# Install or update w4m tools
mkdir tmp
mkdir -p galaxy/tools/w4m
for tool in w4m-tool-lcmsmatching ; do
	cd tmp
	git clone https://github.com/pierrickrogermele/$tool
	cd $tool
	git submodule init
	git submodule update
	ant dist # TODO change it for an "galaxy.install" target that takes a parameter -D GALAXY.INSTALL.DIR=...
# TODO what about the dependencies of the tool (search-mz) ?
	cd ../galaxy/tools/w4m
	tar -xzf ../../../tmp/$tool/dist/*.tar.gz

	# Create tool_conf.xml
done
