Vagrant.configure("2") do |config|
  # Configurations common to all VMs
  config.vm.box = "ubuntu/jammy64"
  config.vm.network "private_network", type: "dhcp"
  config.vm.provision "file", source: "./local-ovn.conf", destination: "/home/vagrant/local-ovn.conf"
  config.vm.provision "file", source: "./local-lb.conf", destination: "/home/vagrant/local-lb.conf"
  config.vm.provision "file", source: "./local-ovs.conf", destination: "/home/vagrant/local-ovs.conf"
  config.vm.provision "shell", path: "post_install.sh"
  config.vm.define "coa-controller" do |vm1|
    vm1.vm.network "private_network", ip: "10.0.114.11", name: "coa-host"
    vm1.vm.provider "virtualbox" do |vb|
      vb.name = "coa-controller"
      vb.memory = "4096"
      vb.cpus = 4
      vb.customize ["modifyvm", :id, "--nic3", "natnetwork"]
      vb.customize ["modifyvm", :id, "--nat-network3", "coa-nat"]
    end
  end
  config.vm.define "coa-compute" do |vm2|
    vm2.vm.network "private_network", ip: "10.0.114.12", name: "coa-host2"
    vm2.vm.provider "virtualbox" do |vb|
      vb.name = "coa-compute"
      vb.memory = "4096"
      vb.cpus = 2
      vb.customize ["modifyvm", :id, "--nic3", "natnetwork"]
      vb.customize ["modifyvm", :id, "--nat-network3", "coa-nat"]
    end
  end
end
