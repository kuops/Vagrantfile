# -*- mode: ruby -*-
# vi: set ft=ruby :

N = 2

Vagrant.configure("2") do |config|
  config.env.enable
  config.vm.box = ENV['OS']
  config.vm.box_check_update = false
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true


  if  N == 1 
    config.vm.hostname = 'ubuntu'
    config.vm.network "private_network", ip: "10.0.8.100"
    config.vm.synced_folder ".", "/script"
    config.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = "1"
      #win10 wsl bugfix https://github.com/hashicorp/vagrant/issues/8604
      vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
    end
  else
    (1..N).each do |i|
      config.vm.define "ubuntu-node-#{i}" do |node|
        node.vm.hostname = "ubuntu-node-#{i}"
        node.vm.network "private_network", ip: "10.0.8.10#{i}"
        node.vm.synced_folder ".", "/script"
        node.vm.provider "virtualbox" do |vb|
          vb.memory = "2048"
          vb.cpus = "1"
          vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
        end
      end
    end
  end


  config.vm.provision "shell", inline: <<-SHELL
    #insert ssh public key to vagrant user.
    if ! [ -f /opt/reg_ssh_pub ];then  
      echo "#{ENV['SSH_PUB']}" >>  /home/vagrant/.ssh/authorized_keys
      echo "done." >  /opt/reg_ssh_pub
    fi
  SHELL


  config.vm.provision "shell", inline: <<-SHELL
    echo "deploy done"
  SHELL
end
