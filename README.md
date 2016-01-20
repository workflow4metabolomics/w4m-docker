Virtual machine for the Workflow4Metabolomics
=============================================

This project has for aim to maintain a [Vagrant](https://www.vagrantup.com) file capable of building a full virtual machine running [Galaxy](https://galaxyproject.org) and an instance of the [Workflow4Metabolomics](http://workflow4metabolomics.org).

The Workflow4Metabolomics, W4M in short, is a French infrastructure offering software tool processing, analyzing and annotating metabolomics data. It is based on the Galaxy platform.


What does it do?
----------------
1. Create a virtual machine (Vagrant)
2. Install Galaxy (https://github.com/galaxyproject/ansible-galaxy)
3. Run Galaxy (https://github.com/galaxyproject/ansible-galaxy)
4. Install "ToolSheded" W4M Tools in Galaxy (https://github.com/galaxyproject/ansible-galaxy-tools and http://workflow4metabolomics.org/)



Prerequisites
-------------

### Vagrant ###
https://www.vagrantup.com/

### Ansible ###
From Python virtualenv
``` {.bash}
virtualenv .venv; . .venv/bin/activate
pip install ansible
```


Installation
------------

``` {.bash}
git clone --recursive git@github.com:lecorguille/w4m-vm.git
```


Settings
--------

You can change the tool you want to be installed in tools-playbook-list/tool_list_LCMS.yaml


Running
-------

Only the Ubuntu versioning is working, currently. The CentOS version does not work, however this would be a priori the preferred choice for the Workflow4Metabolomics team.

From your host:
``` {.bash}
. ~/.venv/bin/activate # optional
cd vagrant-ubuntu
vagrant up
vagrant ssh
```

Now the virtual machine is created and running and you are logged in it. Start the Galaxy server:
``` {.bash}
cd galaxy
./run.sh
```

1. When running for the first time, Galaxy will download and install all required Python modules (eggs), and then run all migration scripts.
2. Then, the tools and their dependencies will be installed. But BEWARE, it's take a long long time to do that (1 or 2 hours). See During tools installations section.


Finally, you can connect to the Galaxy portal from a browser running on your host: <http://localhost:7070/>.


During tools installations
--------------------------

You can monitor the tools installation:
1. Register in <http://localhost:7070/> a user named admin@w4m.org
2. Check the progression: Admin -> Monitor installing repositories


Troubleshooting
---------------

* If anything fails during the migration step, you'll have to rerun it using the following command:
``` {.bash}
sh manage_db.sh upgrade
./run.sh
```

* Sometimes, some dependencies installation fail. You can reinstall them using the graphic interface.

