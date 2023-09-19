Vagrant.configure("2") do |config|
  config.vm.hostname = "controller"
#  config.vm.box = "ubuntu/bionic64"
  config.vm.box = "ubuntu/jammy64"
  config.vm.network "private_network", ip: "10.0.114.11",
    name: "coa-host"
  config.vm.network "private_network", type: "dhcp"
  config.vm.provision "shell", path: "post_install.sh"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "8192"
    vb.cpus = 4
    vb.customize ["modifyvm", :id, "--nic3", "natnetwork"]
    vb.customize ["modifyvm", :id, "--nat-network3", "coa-nat"]
  end
end

