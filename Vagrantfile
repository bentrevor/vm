# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.6.1"

Vagrant.configure("2") do |config|
  config.vm.box = 'ubuntu-12.04_amd64_vmware'
  config.vm.box_url = "http://files.vagrantup.com/precise64_vmware.box"

  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.network :forwarded_port, guest: 8080, host: 8080

  config.ssh.forward_agent = true

  config.vm.provider 'vmware_fusion' do |vb|
    vb.vmx['memsize'] = '8192'
    vb.vmx['numvcpus'] = '2'
  end

  config.vm.provider 'virtualbox' do |vb|
    vb.customize ["modifyvm", :id, "--memory", "8192"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
  end

  # Set the timezone to the host timezone
  require 'time'
  # CST is supposed to be GMT-6, but the time only gets set correctly when I set it to GMT+6, so I swap the '-' with a '+'
  timezone = 'Etc/GMT' + ((Time.zone_offset(Time.now.zone)/60)/60).to_s.gsub('-','+')
  config.vm.provision :shell, :inline => "if [ $(grep -c UTC /etc/timezone) -gt 0 ]; then echo \"#{timezone}\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata; fi"

  config.vm.synced_folder ".", "/vagrant", :disabled => true

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe "git"
    chef.add_recipe "zsh"
    chef.add_recipe "tmux"
    chef.add_recipe "vim"
    chef.add_recipe "ruby"

    chef.add_recipe "java"
    chef.add_recipe "lein"
    chef.add_recipe "node"

    chef.add_recipe "phantomjs"

    chef.add_recipe "postgres"
    chef.add_recipe "mongodb"
    # chef.add_recipe "elasticsearch"

    chef.add_recipe "rbenv"

    chef.add_recipe "autoupdate"
  end
end
