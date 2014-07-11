# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.6.1"

Vagrant.configure("2") do |config|
  config.vm.box = 'debian-7.0_amd64_vbox'

  config.vm.provider 'virtualbox' do |vb|
    vb.customize ["modifyvm", :id, "--memory", "8192"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
  end

  config.vm.define :debian_vm do |t|
  end

  config.ssh.forward_agent = true
  config.vm.network 'forwarded_port', guest: 8080, host: 8888, autocorrect: true
  config.vm.network 'forwarded_port', guest: 22, host: 2323, autocorrect: true

  config.vm.synced_folder 'src', '/home/vagrant/src', :type => 'nfs'

  config.vm.provision :shell, :inline => "echo 'US/Central' | sudo tee /etc/timezone && sudo dpkg-reconfigure --frontend noninteractive tzdata"

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      'user'      => 'vagrant',
      'home_dir'  => "/home/vagrant",
      'full_name' => 'Ben Trevor',
      'email'     => 'btrevor@8thlight.com'
    }

    chef.add_recipe 'git'
    chef.add_recipe 'zsh'
    chef.add_recipe 'tmux'
    chef.add_recipe 'vim'

    chef.add_recipe 'ruby'
    chef.add_recipe 'chruby'

    chef.add_recipe 'java'
    chef.add_recipe 'lein'

    chef.add_recipe 'postgres'
  end
end
