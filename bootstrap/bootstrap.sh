#!/bin/bash
##Run the script as follows
## ./bootstrap.sh <domain name> < document root>
## ./bootsrap.sh test.com /opt/test
# This will create vhost file with server_name=test.com and document root as /opt/test
########
########
DOMAIN=$1
DOC_ROOT=$2
###
apt-get update
apt-get install python-pip git unzip -y
sudo apt-get install python-dev -y
sudo pip install paramiko PyYAML Jinja2 httplib2
git clone git://github.com/ansible/ansible.git --recursive
cd ./ansible
source ./hacking/env-setup
###
wget https://s3.amazonaws.com/devpanel-scripts/ansible/nginx-php.zip
unzip nginx-php.zip
cd ansible-playbooks
#ansible-playbook -i "localhost," -c local boot.yml 
ansible-playbook -i "localhost," -c local boot.yml --extra-vars '{"server_name": '\"$DOMAIN\"'}' --extra-vars '{"document_root": '\"$DOC_ROOT\"'}'
###
###
