# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/wily64"
  config.vm.network "private_network", ip: "192.168.10.10"
  config.ssh.forward_agent = true

  config.vm.provider "virtualbox" do |v|
    mem = `sysctl -n hw.memsize`.to_i / 1024
    mem = mem / 1024 / 4
    v.customize ["modifyvm", :id, "--memory", mem]
  end
end
