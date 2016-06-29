#!/bin/bash

cd /vagrant/provision
ansible-galaxy install zzet.rbenv
ansible-galaxy install geerlingguy.nginx
ansible-galaxy install geerlingguy.java
ansible-galaxy install geerlingguy.elasticsearch
# ansible-galaxy install sansible.kibana
ansible-galaxy install geerlingguy.redis
ansible-galaxy install ANXS.postgresql
ansible-playbook site.yml
