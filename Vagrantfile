Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.network "private_network", type: "static", ip: "192.168.56.11"
  config.vm.provision "shell", path: "post_install.sh"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "8192"
    vb.cpus = 4
  end
end

