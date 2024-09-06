# Ansible

Download and run `run-local.sh` to conveniently provision your new developer machine; it will install required apt packages, clone this Github repo and run the Ansible playbook on your current host machine. If you want to manually run with specific tasks (tags):

```bash
sudo apt update && sudo apt install ansible git -y
git clone --depth 1 --branch main "https://github.com/akyidrian/ansible.git" /tmp/ansible
ansible-playbook --inventory localhost, --connection local --ask-vault-pass --tags all --skip-tags "" /tmp/ansible/playbook.yml
# or, if you have a `vault-password.txt`
ansible-playbook --inventory localhost, --connection local --vault-password-file /tmp/ansible/vault-password.txt --tags all --skip-tags "" /tmp/ansible/playbook.yml
```

Note, you can list available playbook tags with:

```bash
ansible-playbook --list-tags /tmp/ansible/playbook.yml
```

## Testing with Docker

```bash
./docker-clean.sh && ./docker-build.sh && ./docker-run.sh

# Inside the Docker container:
./ansible/run-local.sh
```

## Testing Playbook with Vagrant / VirtualBox

### Control Machine Setup

Download:
 * [Vagrant](https://releases.hashicorp.com/vagrant/)
 * [VirtualBox](https://www.virtualbox.org/wiki/Linux_Downloads)

Install:
 ```bash
sudo dpkg -i vagrant_2.4.1-1_amd64.deb
sudo dpkg -i virtualbox-7.0_7.0.20-163906\~Ubuntu\~jammy_amd64.deb
```

Run the following:
```bash
vagrant box add ubuntu/jammy64
vagrant plugin install vagrant-vbguest
```

### Run Playbook through Ansible SSH

```bash
vagrant destroy -f && vagrant up
vagrant vbguest --do install # for VirtualBox Guest Additions, if necessary
```

### Target VirtualBox Machine Already Running?

Run playbook via `ansible-playbook`:
```bash
ansible-playbook --inventory .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory --ask-vault-pass playbook.yml 
```

Note, destroying and recreating VM can cause the SSH host key to change, which will result in a SSH connection error with `ansible-playbook`. You may need to run the following occationally:
```bash
ssh-keygen -f "/home/aydin/.ssh/known_hosts" -R "[127.0.0.1]:2222"
```

If you're tired of entering the vault password and deleting host keys, create a `vault-password.txt` file containing the password and run:
```bash
ansible-playbook --inventory .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory --vault-password-file vault-password.txt --extra-vars "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" playbook.yml
```

### Want to run local instead?

```bash
vagrant destroy -f && vagrant up --no-provision
vagrant ssh -c "bash ansible/run-local.sh"
```
