Virtual machine for the Workflow4Metabolomics
=============================================

This project has for aim to maintain a [Vagrant](https://www.vagrantup.com) file capable of building a full virtual machine running [Galaxy](https://galaxyproject.org) and an instance of the [Workflow4Metabolomics](http://workflow4metabolomics.org).

The Workflow4Metabolomics, W4M in short, is a French infrastructure offering software tool processing, analyzing and annotating metabolomics data. It is based on the Galaxy platform.

Running
-------

Only the Ubuntu versioning is working, currently. The CentOS version does not work, however this would be a priori the preferred choice for the Workflow4Metabolomics team.

From your host:
``` {.bash}
cd vagrant-ubuntu
vagrant up
vagrant ssh
```

Now the virtual machine is created and running and you are logged in it. Start the Galaxy server:
``` {.bash}
cd galaxy
./run.sh
```
When running for the first time, Galaxy will download and install all required Python modules (eggs), and then run all migration scripts.
If anything fails during the migration step, you'll have to rerun it using the following command:
``` {.bash}
sh manage_db.sh upgrade
./run.sh
```

Finally, you can connect to the Galaxy portal from a browser running on your host: <http://localhost:8080/>.
