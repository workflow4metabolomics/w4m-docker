#!/usr/bin/env bash

# FIXME R not installed.
yum install R.x86_64

# FIXME Galaxy installed as root.
git clone https://github.com/galaxyproject/galaxy
cd galaxy
git checkout -b master origin/master
