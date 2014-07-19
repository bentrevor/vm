# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.6.1"

Vagrant.configure("2") do |config|
  vm_name = if File.file?('.vm-name')
              `cat .vm-name`
            else
              'other'
            end
  hostname = "#{vm_name}_vm"
  config.vm.host_name = hostname

  config.vm.network 'private_network', :ip => '192.168.56.56'
  config.vm.box = 'ubuntu-12.04_amd64_vbox'
  config.ssh.forward_agent = true
  config.vm.synced_folder 'src', '/home/vagrant/src', :type => 'nfs'

  config.vm.network 'forwarded_port', guest: 8080, host: 8888, autocorrect: true
  config.vm.network 'forwarded_port', guest: 22, host: 2323, autocorrect: true

  config.vm.provider 'virtualbox' do |vb|
    vb.customize ["modifyvm", :id, "--name", hostname]
    vb.customize ["modifyvm", :id, "--memory", 8192]
    vb.customize ["modifyvm", :id, "--ioapic", "on", '--cpus', 4]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.vm.define hostname do |t|
  end

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
