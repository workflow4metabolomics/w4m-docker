#!/usr/bin/env bash

action=$1

# Run Galaxy
if [ -d galaxy ] ; then
	cd galaxy
    if [[ $action == "start" ]]
    then
        ./run.sh --daemon
    fi
	if [[ $action == "restart" ]]
    then
        ./run.sh stop; ./run.sh start
    fi
    #TODO: must be replace by galaxy_tools/taks/restart_galaxy.yml
    while [[ $(grep -c "serving on" paster.log) -eq 0 ]]
    do
        if [[ $(grep -c "Removing PID" paster.log) -eq 1 ]]
        then
            echo "Failed" 2> /dev/stderr
            break
        fi
        echo "Waiting for Galaxy..."
        sleep 5
    done
fi
