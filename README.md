Virtual machine for the Workflow4Metabolomics
=============================================

The [Workflow4Metabolomics](http://workflow4metabolomics.org), W4M in short, is a French infrastructure offering software tool processing, analyzing and annotating metabolomics data. It is based on the Galaxy platform.

This project has for aim to maintain [Docker](https://www.docker.com) and [Vagrant](https://www.vagrantup.com) files capable of building a full virtual machine running [Galaxy](https://galaxyproject.org) and an instance of the [Workflow4Metabolomics](http://workflow4metabolomics.org).


NOTICE 
------

We are currently pushing our developments on GitHub and on the ToolShed.. 
Since april of this year, we also try to prioritize the new system to deal with the dependencies : conda.
This work is still in progress. Thus in those VM, you will only find those tools available on the TS, which use the conda dependencies and pass Travis test.
Sorry for that!


Dependencies using Conda
------------------------

[![bioconda-badge](https://img.shields.io/badge/install%20with-bioconda-brightgreen.svg?style=flat)](http://bioconda.github.io) 

[Conda](http://conda.pydata.org/) is package manager that among many other things can be used to manage Python packages. It is becoming the default dependency manager within Galaxy.


Which VM
--------

So make your choice
- Use [Docker](#docker)
- Use [Vagrant](#vagrant)


Docker
------

### What is it?

This Docker container is based on the quay.io/bgruening/galaxy:16.04 (https://github.com/bgruening/docker-galaxy-stable) as a [Galaxy flavour](https://github.com/bgruening/docker-galaxy-stable/#list-of-galaxy-flavours)
Nested in this Docker image, the script [install_tools_wrapper.sh](https://github.com/bgruening/docker-galaxy-stable/blob/master/galaxy/install_tools_wrapper.sh) will install tools from ToolSheds using Ansible roles provided by the Galaxy project (https://github.com/galaxyproject/ansible-galaxy-tools)
Get more documentations this Docker container on https://github.com/bgruening/docker-galaxy-stable: [Usage to save data on this read-only system](https://github.com/bgruening/docker-galaxy-stable/#usage), [using an external Slurm cluster](https://github.com/bgruening/docker-galaxy-stable/#using-an-external-slurm-cluster), ...


### Prerequisites

#### Docker
https://www.docker.com

###Make a sub-choice:
 - Use an existing image available on [Docker Hub](https://hub.docker.com/r/workflow4metabolomics/galaxy-workflow4metabolomics/) and start from the [Step 1](#step-1-running-the-docker-container)
 - From this repository a custom docker image from the [Custom Build Section](#custom-build-section-building-a-custom-docker-container-from-this-repository)


### Step 1: Running the Docker container

If you have just build a docker image through the [Custom Build Section](#custom-build-section-building-a-custom-docker-container-from-this-repository). Omit workflow4metabolomics/ in the docker image name

#### Detached/Daemon mode

From your host:
``` {.bash}
docker pull workflow4metabolomics/galaxy-workflow4metabolomics # to update the local image version
docker run -d -p 8080:80 workflow4metabolomics/galaxy-workflow4metabolomics

# check that your docker is running
docker ps

# to get a ssh connection and use bash, you need your CONTAINER ID (`docker ps`)
docker exec -i -t ed6031485d06 /bin/bash

```

#### Interactive mode

From your host:
``` {.bash}
docker pull workflow4metabolomics/galaxy-workflow4metabolomics # to update the local image version
docker run -i -t -p 8080:80 workflow4metabolomics/galaxy-workflow4metabolomics /bin/bash
```

From the Docker image:
``` {.bash}
startup
```


#### MORE: FTP support and Persistent data


``` {.bash}
docker run -d -p 8080:80 -p 8021:21 -p 8022:22 -v /home/user/galaxy_storage/:/export/ workflow4metabolomics/galaxy-workflow4metabolomics
```

Because Docker container are "read-only", you will lost all your changes within the container at shutdown until you ask the Galaxy instance to write in a folder mounted from the host `/home/user/galaxy_storage/` under `/export/` into the container.

From a MacOX:
> There are some issue with those two features depending on which Docker solution was chosen. See this thread: https://github.com/bgruening/docker-galaxy-stable/issues/210
> - Docker for Mac: the export directory works and the SFTP too using Filezilla but not the FTP 
> - Docker Toolbox: the FTP works but not the export directory


### Step 2: Use Galaxy

Finally, after maybe a couple of minute (dependeing of your machine), you can connect to the Galaxy portal from a browser running on your host: <http://localhost:8080/>.

You can login as administrator of your Galaxy instance using the login admin@galaxy.org and the password admin



### Custom Build Section: building a custom Docker container from this repository

If you want to add or remove tools from the "official" workflow4metabolomics docker container

#### Installation

``` {.bash}
git clone --recursive git@github.com:workflow4metabolomics/w4m-vm.git
```


#### Settings

You can change the tools you want to be installed in tools-playbook-list/docker-ubuntu/tool_list_LCMS.yaml


#### The Building step

From your host:
``` {.bash}
docker build -t galaxy-workflow4metabolomics .

# check your images
docker images
```

#### Running step

See [Step 1](#step-1-running-the-docker-container)


Vagrant
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
git clone --recursive git@github.com:workflow4metabolomics/w4m-vm.git
```


### Settings

You can change the tools you want to be installed in tools-playbook-list/tool_list_LCMS.yaml


### Running the build

Only the Ubuntu versioning is working, currently. The CentOS version does not work, however this would be a priori the preferred choice for the Workflow4Metabolomics team.


To get a production instance
``` {.bash}
. ~/.venv/bin/activate # optional
cd vagrant-ubuntu
TOOL_LIST='../tools-playbook-list/tool_list_LCMS.yaml' vagrant up
```

To get a dev instance
``` {.bash}
. ~/.venv/bin/activate # optional
cd vagrant-ubuntu
TOOL_LIST='../tools-playbook-list/tool_list_LCMS_dev.yaml' vagrant up
```

1. When running for the first time, Galaxy will download and install all required Python modules (eggs), and then run all migration scripts.
2. Then, the tools will be installed.
3. Since we use conda to manage the dependencies, the first time you launch a tool, Galaxy will install using conda the tool dependencies. This step can take a few minutes. Keep cool!


### Use Galaxy and the VM

#### Web interface

Finally, you can connect to the Galaxy portal from a browser running on your host: <http://localhost:8080/>.

#### SSH 

To access through SSH to your image if you build it

``` {.bash}
vagrant ssh
```

Or if you get directly a .ova
``` {.bash}
ssh -Y vagrant@127.0.0.1 -p 2222
```

### During tools installations

You can monitor the tools installation:

1. Register in <http://localhost:8080/> a user named admin@w4m.org

### Troubleshooting

* If anything fails during the migration step, you'll have to rerun it using the following command:
``` {.bash}
sh manage_db.sh upgrade
./run.sh
```





