# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/jammy64" # 22.04
  config.ssh.insert_key = false
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider :virtualbox do |v|
    v.cpus = 2
    v.memory = 4096 # MB
    v.customize ["modifyvm", :id, "--vram", "128"] # MB
    v.customize ['modifyvm', :id, '--graphicscontroller', 'vmsvga']
    v.linked_clone = true
    v.gui = true
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.vault_password_file = "vault-password.txt"
#    ansible.ask_vault_pass = true
  end
end
