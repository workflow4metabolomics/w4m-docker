FROM ubuntu:14.04
#FROM ansible/ubuntu14.04-ansible:stable

MAINTAINER Pierrick Roger (pierrick.roger@gmail.com)

# Update package database
RUN apt-get update

# Add apt-add-repository tool
#RUN apt-get install --no-install-recommends -y software-properties-common

# Install Ansible
#RUN apt-add-repository ppa:ansible/ansible
#RUN apt-get update
#RUN apt-get install -y ansible
RUN apt-get install -y git
RUN git clone git://github.com/ansible/ansible.git --recursive
WORKDIR ./ansible
RUN apt-get install -y python python-setuptools
RUN apt-get install -y gcc
RUN apt-get install -y python-dev
RUN apt-get install -y libgmp-dev
#RUN bash -c "source ./hacking/env-setup && easy_install pip && pip install paramiko PyYAML Jinja2 httplib2 six && make all install"
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
ADD vagrant-ubuntu/galaxyserver.yml /files/galaxy-ubuntu/
WORKDIR /files/galaxy-ubuntu
RUN ansible-playbook galaxyserver.yml -c local

# Clean up
RUN apt-get clean && apt-get autoremove -y && rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/* /var/tmp/*

# Define Entry point script
#RUN chmod +x /files/lcmsmatching/search-mz
#ENTRYPOINT ["/files/lcmsmatching/search-mz"]
#ENTRYPOINT ["/files/lcmsmatching/r-msdb/search-mz"]
ENTRYPOINT ["/home/vagrant/galaxy/run.sh"]
