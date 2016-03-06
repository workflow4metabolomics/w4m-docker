FROM ubuntu:14.04
#FROM ansible/ubuntu14.04-ansible:stable

MAINTAINER Pierrick Roger (pierrick.roger@gmail.com)

# Update package database
RUN apt-get update

# Install Ansible
RUN apt-get install -y git
RUN git clone git://github.com/ansible/ansible.git --recursive
WORKDIR ./ansible
RUN apt-get install -y python python-setuptools
RUN apt-get install -y gcc
RUN apt-get install -y python-dev
RUN apt-get install -y libgmp-dev
RUN easy_install pip
RUN pip install paramiko PyYAML Jinja2 httplib2 six
RUN apt-get install -y libffi-dev
RUN apt-get install -y libssl-dev
RUN pip install 'requests[security]'
RUN apt-get install -y make
RUN make all install
RUN ansible --version
RUN mkdir /etc/ansible
RUN echo '[local]\nlocalhost\n' > /etc/ansible/hosts

# Run ansible role
ADD ansible-galaxy /files/ansible-galaxy
ADD vagrant-ubuntu/galaxyserver.yml /files/galaxy-ubuntu/galaxyserver.yml
WORKDIR /files/galaxy-ubuntu
RUN ansible-playbook galaxyserver.yml -c local

# Clean up
RUN apt-get clean && apt-get autoremove -y && rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/* /var/tmp/*

EXPOSE :8080
EXPOSE :80
EXPOSE :21
EXPOSE :8800
EXPOSE :9002

# Define Entry point script
ENTRYPOINT ["/home/galaxy/run.sh"]
#ENTRYPOINT ["/bin/ls"]
