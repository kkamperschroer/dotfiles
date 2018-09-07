#!/bin/bash

# Baseline pieces required to run playbook
sudo apt update
sudo apt install software-properties-common -y
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible cowsay -y

# Handoff remaining work to ansible
ansible-playbook playbook.yml
