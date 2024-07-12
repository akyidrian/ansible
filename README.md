# Ansible

Destroying and recreating VMs can cause the SSH host key to change, which will result in a SSH connection error. You may need to run:
```bash
ssh-keygen -f "/home/aydin/.ssh/known_hosts" -R "[127.0.0.1]:2222"
```

Before running the playbook via `ansible-playbook`:
```bash
ansible-playbook -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory playbook.yml --ask_vault_pass
```

If you're tired of entering the vault password and deleting host keys, create a `vault-password.txt` file containing the password and run:
```bash
ansible-playbook -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory playbook.yml --vault-password-file vault-password.txt -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'"
```
