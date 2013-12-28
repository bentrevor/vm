
Change the `config.vm.box` in Vagrantfile to the name of a box on your system.

Change the [VBoxManage](http://www.virtualbox.org/manual/ch08.html) settings for RAM and cpus with `config.vm.provider` in `Vagrantfile`.

Install plugins with `vagrant plugin install vagrant-vbguest` and `vagrant plugin install
vagrant-berkshelf`.  I wasn't able to install vbguest while in the vm directory because it would
fail with an error too quickly, so I just installed it from my home directory.

Run `vagrant up` to provision a new box.
