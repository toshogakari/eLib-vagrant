#!/bin/bash

declare -a rm_dir=( \
  # "/var/lib/apt/lists/lock" \
  # "/var/cache/apt/archives/lock" \
  "/var/lib/dpkg/lock" \
)

for rm_item in ${rm_dir[@]}; do
  if [[ -f $rm_item ]]; then
    rm -rf ${rm_item}
  fi
done

apt-get -y update

# "/dev/null 2>&1" is avoid below output
# ==> default: dpkg-preconfigure: unable to re-open stdin: No such file or directory
apt-get -y install python2.7
apt-get -y install software-properties-common
apt-add-repository ppa:ansible/ansible
apt-get -y update
apt-get -y install ansible > /dev/null 2>&1

cd /vagrant/provision
ansible-galaxy install zzet.rbenv
ansible-galaxy install geerlingguy.nginx
ansible-galaxy install geerlingguy.java
ansible-galaxy install geerlingguy.elasticsearch
# ansible-galaxy install sansible.kibana
ansible-galaxy install geerlingguy.redis
ansible-galaxy install ANXS.postgresql
ansible-playbook site.yml
