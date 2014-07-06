# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'secrets'

Vagrant.require_version ">= 1.6.1"

Vagrant.configure("2") do |config|
  config.vm.box = 'debian-7.0_amd64_vbox'
  # config.vm.box_url = "http://files.vagrantup.com/precise64_vmware.box"

  config.vm.provider 'virtualbox' do |vb|
    vb.customize ["modifyvm", :id, "--memory", "8192"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
  end

  config.vm.define :debian_vm do |t|
  end

  config.ssh.forward_agent = true
  config.vm.synced_folder ".", "/vagrant", :disabled => true
  config.vm.provision :shell, :inline => "echo 'US/Central' | sudo tee /etc/timezone && sudo dpkg-reconfigure --frontend noninteractive tzdata"
  config.vm.provision :shell, :inline => "sudo apt-get update"

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      'user'      => 'vagrant',
      'home_dir'  => "/home/vagrant",
      'full_name' => 'Ben Trevor',
      'email'     => 'btrevor@8thlight.com'
    }

    # core
    chef.add_recipe 'git'
    chef.add_recipe 'zsh'
    chef.add_recipe 'tmux'
    # chef.add_recipe 'vim'
    chef.add_recipe 'emacs'

    # languages
    chef.add_recipe 'ruby'
    chef.add_recipe 'chruby'

    chef.add_recipe 'java'
    chef.add_recipe 'lein'

    # data stores
    chef.add_recipe 'postgres'
    chef.add_recipe 'mysql'
    chef.add_recipe 'sqlite'
  end
end
