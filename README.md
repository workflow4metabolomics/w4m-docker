Virtual machines for the Workflow4Metabolomics
==============================================

This project has for aim to maintain a set of virtual machine builders. These builders use technologies such as [Vagrant](https://www.vagrantup.com), [Ansible](https://www.ansible.com/) or [Docker](https://www.docker.com/). The resulting virtual machines are currently only able to run an empty instance of [Galaxy](https://galaxyproject.org), however in the near future they will be populated with Galaxy tools from the [Workflow4Metabolomics](http://workflow4metabolomics.org) in order to provide full virtual versions of the [Workflow4Metabolomics](http://workflow4metabolomics.org) that one could use for running locally as a development instance (i.e.: for developing new tools for the Workflow4Metabolomics, or maintaining/upgrading new ones) or as a production instance.

The *Workflow4Metabolomics*, W4M in short, is a French infrastructure offering software tool processing, analyzing and annotating metabolomics data. It is based on the Galaxy platform.

## Vagrant virtual machines

The vagrant builder can be found inside `vagrant-ubuntu` (the `vagrant-centos` folder is not functinal yet). It uses the `ansible-galaxy` project that defines a general Ansible playbook to install Galaxy.

### Prerequisites

#### Vagrant
https://www.vagrantup.com/

#### Ansible
From Python virtualenv
```bash
virtualenv .venv; . .venv/bin/activate
pip install ansible
```

### Running

Only the Ubuntu versioning is working, currently. The CentOS version does not work, however this would be a priori the preferred choice for the Workflow4Metabolomics team.

From your host:
```bash
. ~/.venv/bin/activate # optional
cd vagrant-ubuntu
vagrant up
vagrant ssh
```

Now the virtual machine is created and running and you are logged in it. Start the Galaxy server:
```bash
cd galaxy
./run.sh
```
When running for the first time, Galaxy will download and install all required Python modules (eggs), and then run all migration scripts.
If anything fails during the migration step, you'll have to rerun it using the following command:
```bash
sh manage_db.sh upgrade
./run.sh
```

Finally, you can connect to the Galaxy portal from a browser running on your host: <http://localhost:7070/>.

## Docker container

The docker file is located at the root of the project. We are not going to explain how to install and run Docker here, please refer to the general documentation of Docker.
Do not forget that if you run under MacOS-X, since Docker only run exclusively on Linux, you'll have to run Docker inside a virtual machine running a Linux system. One solution is to use the docker-machine tool, which will make this almost transparent.

To build the machine run from inside the root folder:
```bash
docker build -t galaxy .
```

Then to start the container:
```bash
docker run -p 8080:8080 galaxy
```

For MacOS-X, if you are using `docker-machine`, you need to open a tunnel from your host to the docker-machine in order to be able to access the Galaxy server. Run the following command, and let it open (i.e.: do not quit):
``` bash
docker-machine ssh default -L 8080:localhost:8080
```
Replace *default* with your docker-machine machine name.

Now you should be able to open the Galaxy server in your browser: <http:\\localhost:8080>.
