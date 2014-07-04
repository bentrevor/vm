
## Installation
- Change the `config.vm.box` in Vagrantfile to the name of a box on your system.
- Change the [VBoxManage](http://www.virtualbox.org/manual/ch08.html) settings for RAM and cpus with `config.vm.provider` in `Vagrantfile`.
- Run `vagrant plugin install vagrant-vbguest` to install a plugin for virtualbox.
- Run `vagrant up` to provision a new box.
