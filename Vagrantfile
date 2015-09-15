# -*- mode: ruby -*-
# vi: set ft=ruby :
# 
# 
# MDW Setup
# @author Jaroslav Kuchař
# 

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "puphpet/debian75-x64"

  config.vm.hostname = "mi-mdw"

  config.vm.network :forwarded_port, guest: 7001, host: 7001

  config.omnibus.chef_version = :latest

  config.vm.provider :virtualbox do |vb|
    vb.gui = true  
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--vram", "128"]
  end

  # vagrant plugin install vagrant-vbguest
  # vagrant plugin install vagrant-omnibus
  
  config.vm.provision :chef_solo do |chef|
    chef.custom_config_path = "Vagrantfile.chef"
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe("mimdw") 
  end
end
