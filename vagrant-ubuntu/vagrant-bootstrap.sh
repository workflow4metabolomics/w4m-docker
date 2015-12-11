#!/usr/bin/env bash

apt-get update
apt-get install -y r-base
apt-get install -y git

# Requirements for installing and testing w4m-tool-lcmsmatching
#apt-get install -y ant
#R -e "install.packages('getopt', dependencies = TRUE, repos='http://lib.ugent.be/CRAN/')"
