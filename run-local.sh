#!/usr/bin/env bash
ansible-playbook -i localhost, -c local playbook.yml --ask-vault-pass
