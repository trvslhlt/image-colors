# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "boxcutter/ubuntu1604"
  config.vm.box_check_update = false
  config.vm.network "forwarded_port", guest: 80, host: 8000
  config.vm.provision "shell", path: "provision.sh"

end
