#!/bin/bash

## Before running this script, it's assumed you've alredy got `git` setup and whatever SSH keys in place to pull from GitHub
# This assumption is made because this is hosted in a GitHub repo, so hopefully you pulled it down with git.

# Baseline pieces required to run ansible-playbook
sudo apt update
sudo apt install software-properties-common -y
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible cowsay -y

# Handoff remaining work to ansible
ansible-playbook playbook.yml -vv
