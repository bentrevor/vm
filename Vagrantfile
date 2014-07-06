# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.6.1"

Vagrant.configure("2") do |config|
  config.vm.box = 'ubuntu-12.04_amd64_vmware'
  # config.vm.box_url = "http://files.vagrantup.com/precise64_vmware.box"

  config.ssh.forward_agent = true

  config.vm.provider 'vmware_fusion' do |vb|
    vb.vmx['memsize'] = '8192'
    vb.vmx['numvcpus'] = '2'
  end

  config.vm.provider 'virtualbox' do |vb|
    vb.customize ["modifyvm", :id, "--memory", "8192"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
  end

  # Set the timezone to US/Central
  config.vm.provision :shell, :inline => "echo 'US/Central' | sudo tee /etc/timezone && sudo dpkg-reconfigure --frontend noninteractive tzdata"

  # disable default synced folder
  config.vm.synced_folder ".", "/vagrant", :disabled => true

  config.vm.provision :chef_solo do |chef|
    user = 'vagrant'
    chef.json = {
      'user'      => user,
      'home_dir'  => "/home/#{user}",
      'full_name' => 'Ben Trevor',
      'email'     => 'btrevor@8thlight.com'
    }

    # core
    chef.add_recipe 'git'
    chef.add_recipe 'zsh'
    chef.add_recipe 'tmux'
    # chef.add_recipe 'vim'
    # chef.add_recipe 'emacs'

    # languages
    chef.add_recipe 'ruby'
    chef.add_recipe 'chruby'

    # chef.add_recipe 'java'
    # chef.add_recipe 'lein'
    # chef.add_recipe 'node'

    # data stores
    # chef.add_recipe 'postgres'
    # chef.add_recipe 'mysql'
    # chef.add_recipe 'sqlite'
    # chef.add_recipe 'redis'
    # chef.add_recipe 'mongodb'
  end
end
