#!/bin/bash

if [[ -f /var/lib/apt/lists/lock ]]; then
  rm /var/lib/apt/lists/lock
fi

if [[ -f /var/cache/apt/archives/lock ]]; then
  rm /var/cache/apt/archives/lock
fi

apt-get -y update

# "/dev/null 2>&1" is avoid below output
# ==> default: dpkg-preconfigure: unable to re-open stdin: No such file or directory
# apt-get -y install python2.7
# apt-get -y install software-properties-common python-software-properties
# apt-add-repository ppa:ansible/ansible
# apt-get -y update
# apt-get -y upgrade
# apt-get -y install ansible # > /dev/null 2>&1

# cd /vagrant/provision
# ansible-playbook playbook.yml
