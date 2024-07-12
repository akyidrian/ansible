#!/usr/bin/env bash
ANSIBLE_REPO=https://github.com/akyidrian/ansible.git
ANSIBLE_DIR=/tmp/ansible
ORIGINAL_DIR=$(pwd)
git clone --depth 1 --branch main "$ANSIBLE_REPO" "$ANSIBLE_DIR"
sudo apt-get update && sudo apt-get install ansible -y
cd $ANSIBLE_DIR
ansible-playbook -i localhost, -c local playbook.yml --ask-vault-pass
cd "$ORIGINAL_PATH"
rm -rf $ANSIBLE_DIR
