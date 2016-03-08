FROM ubuntu:14.04
#FROM ansible/ubuntu14.04-ansible:stable

MAINTAINER Pierrick Roger (pierrick.roger@gmail.com)

# Update package database and add required dependencies.
RUN apt-get update && apt-get install -y git gcc libgmp-dev libffi-dev libssl-dev make python python-dev python-setuptools wget

# Install Ansible
RUN git clone --recursive -b v2.0.0.1-1 git://github.com/ansible/ansible.git
WORKDIR ./ansible
RUN easy_install pip
#RUN pip install paramiko PyYAML Jinja2 httplib2 six
RUN pip install PyYAML Jinja2 httplib2 six
RUN pip install 'requests[security]'
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
RUN apt-get clean && apt-get autoremove -y && rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/* /var/tmp/* /ansible /files/ansible-galaxy

EXPOSE :8080
#EXPOSE :80
#EXPOSE :21
#EXPOSE :8800
#EXPOSE :9002

# Define Entry point script
ENTRYPOINT ["/home/vagrant/galaxy/run.sh"]
