# -*- mode: ruby -*-
# vi: set ft=ruby :

# see https://github.com/dotless-de/vagrant-vbguest/issues/64
require 'vagrant-vbguest' unless defined? VagrantVbguest::Config
class CloudUbuntuVagrant < VagrantVbguest::Installers::Ubuntu
  def install(opts=nil, &block)
    communicate.sudo("apt-get -y -q purge virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11", opts, &block)
    super
  end
end

Vagrant.configure("2") do |config|
  config.vm.box = 'precise64'
  # config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-i386-vagrant-disk1.box"
  config.vbguest.installer = CloudUbuntuVagrant

  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.network :forwarded_port, guest: 8080, host: 8080

  config.ssh.forward_agent = true

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "8192"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
  end

  # Set the timezone to the host timezone
  require 'time'
  # CST is supposed to be GMT-6, but the time only gets set correctly when I set it to GMT+6, so I swap the '-' with a '+'
  timezone = 'Etc/GMT' + ((Time.zone_offset(Time.now.zone)/60)/60).to_s.gsub('-','+')
  config.vm.provision :shell, :inline => "if [ $(grep -c UTC /etc/timezone) -gt 0 ]; then echo \"#{timezone}\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata; fi"

  config.vm.synced_folder ".", "/vagrant"

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
