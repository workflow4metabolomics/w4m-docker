#!/usr/bin/env bash

# Run Galaxy
if [ -d galaxy ] ; then
	cd galaxy
	./run.sh --daemon
fi
