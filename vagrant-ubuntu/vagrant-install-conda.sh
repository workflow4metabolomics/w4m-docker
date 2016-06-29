#apt-get update
#apt-get install -y python-virtualenv
#virtualenv .venv_planemo
#. .venv_planemo/bin/activate
#pip install planemo
#planemo conda_init --conda_prefix /home/vagrant/miniconda2
#echo "export PATH=/home/vagrant/miniconda2/bin/:$PATH" >> .bashrc
#source .bashrc

mkdir /deps
chown vagrant /deps
cd ~vagrant
ln -s /deps .