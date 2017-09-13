# Build vagrant base boxes with packer

## Install the following

* [Install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Install Vagrant](http://www.vagrantup.com/)
* [Install Packer](http://www.packer.io/downloads.html)

## Use a box

    packer build template.json

    vagrant box add #{builded-box} ${box_name}

    vagrant init ${box_name}
    vagrant up && vagrant ssh

### Fix VirtualBox PATH for windows

Add the virtualbox path to the %path% variable.
