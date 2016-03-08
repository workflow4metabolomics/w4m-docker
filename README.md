Virtual machine for the Workflow4Metabolomics
=============================================

The [Workflow4Metabolomics](http://workflow4metabolomics.org), W4M in short, is a French infrastructure offering software tool processing, analyzing and annotating metabolomics data. It is based on the Galaxy platform.

This project has for aim to maintain [Vagrant](https://www.vagrantup.com) and [Docker](https://www.docker.com) files capable of building a full virtual machine running [Galaxy](https://galaxyproject.org) and an instance of the [Workflow4Metabolomics](http://workflow4metabolomics.org).


So make your choice
- Use [Vagrant](#headvagrant)
- Use [Docker](#headdocker)


<a id="headvagrant"></a>Vagrant
-------

### What does it do?

1. Create a virtual machine (Vagrant and https://github.com/pierrickrogermele/w4m-vm)
2. Install Galaxy (https://github.com/galaxyproject/ansible-galaxy)
3. Start Galaxy 
4. Install "ToolSheded" W4M Tools in Galaxy (https://github.com/galaxyproject/ansible-galaxy-tools and http://workflow4metabolomics.org/)
5. Restart Galaxy 



### Prerequisites

#### Vagrant
https://www.vagrantup.com/

#### Ansible
``` {.bash}
virtualenv .venv; . .venv/bin/activate # optional
pip install ansible
```


### Installation

``` {.bash}
git clone --recursive git@github.com:lecorguille/w4m-vm.git
```


### Settings

You can change the tools you want to be installed in tools-playbook-list/tool_list_LCMS.yaml


### Running

Only the Ubuntu versioning is working, currently. The CentOS version does not work, however this would be a priori the preferred choice for the Workflow4Metabolomics team.


To get a production instance
``` {.bash}
. ~/.venv/bin/activate # optional
cd vagrant-ubuntu
TOOL_LIST='../tools-playbook-list/tool_list_LCMS.yaml' vagrant up
vagrant ssh
```

To get a dev instance
``` {.bash}
. ~/.venv/bin/activate # optional
cd vagrant-ubuntu
TOOL_LIST='../tools-playbook-list/tool_list_LCMS_dev.yaml' vagrant up
vagrant ssh
```

1. When running for the first time, Galaxy will download and install all required Python modules (eggs), and then run all migration scripts.
2. Then, the tools and their dependencies will be installed. But BEWARE, it's take a long long time to do that (1 or 2 hours). See During tools installations section.

Finally, you can connect to the Galaxy portal from a browser running on your host: <http://localhost:8080/>.

### During tools installations

You can monitor the tools installation:

1. Register in <http://localhost:8080/> a user named admin@w4m.org
2. Check the progression: Admin -> Monitor installing repositories

### Troubleshooting

* If anything fails during the migration step, you'll have to rerun it using the following command:
``` {.bash}
sh manage_db.sh upgrade
./run.sh
```

* Sometimes, some dependencies installation fail. You can reinstall them using the graphic interface.



<a id="headdocker"></a>Docker
------

### What is it?

This Docker container is based on the quay.io/bgruening/galaxy:16.01 (https://github.com/bgruening/docker-galaxy-stable)
Nested in this Docker image, the script [install_tools_wrapper.sh](https://github.com/bgruening/docker-galaxy-stable/blob/master/galaxy/install_tools_wrapper.sh) will install tools from ToolSheds using Ansible roles provided by the Galaxy project (https://github.com/galaxyproject/ansible-galaxy-tools)

### Current issue

There is a problem during the library R mzR compilation. So we can say that this docker build is "**nonfunctional**" :(
See: https://support.bioconductor.org/p/73159/

```
make: *** [pwiz/data/common/Unimod.o] Error 4
ERROR: compilation failed for package ‘mzR’
```

### Prerequisites

#### Docker
https://www.docker.com

##### For MacOS
> Because MacOS can't launch Docker directly, you need to install the Docker Toolbox. It will launch a Linux VM to allow you to use Docker. 
> https://docs.docker.com/engine/installation/mac/ 



### Step 1: Building the Docker container

#### Installation

``` {.bash}
git clone --recursive git@github.com:lecorguille/w4m-vm.git
```


#### Settings

You can change the tools you want to be installed in tools-playbook-list/docker-ubuntu/tool_list_LCMS.yaml


### The Running step

##### For MacOS
> Because MacOS can't launch Docker directly, you need to launch a Linux VM.
> Launch the "[Docker Quickstart Terminal](https://docs.docker.com/engine/installation/mac/#from-the-docker-quickstart-terminal)" application


From your host:
``` {.bash}
docker build -t galaxy-workflow4metabolomics:2.5.0 .

# check your images
docker images
```


### Step 2: Running the Docker container

#### Interactive mode

From your host:
``` {.bash}
docker run -i -t -p 8080:80 galaxy-workflow4metabolomics:2.5.0 /bin/bash
```

From the Docker image:
``` {.bash}
startup
```

#### Detached/Daemon mode

From your host:
``` {.bash}
docker run -d -p 8080:80 galaxy-workflow4metabolomics:2.5.0

# check that your docker is running
docker ps

# to get a ssh connection and use bash, you need your CONTAINER ID (`docker ps`)
docker exec -i -t ed6031485d06 /bin/bash

```


### Step 3: Use Galaxy

Finally, you can connect to the Galaxy portal from a browser running on your host: <http://localhost:8080/>.

You can login as administrator of your Galaxy instance using the login admin@galaxy.org and the password admin

##### For MacOS
> Instead of "localhost", you need to use the Linux VM IP address.
> ``` {.bash}
> docker-machine ip default
> ```


