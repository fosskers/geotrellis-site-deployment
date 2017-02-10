# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    # Ubuntu 16.04 LTS
    config.vm.box = "fosskers/docker-1.12"

    # Docker permissions are available for `ubuntu` user only.
    config.ssh.username = "ubuntu"

    # Ports to the services
    config.vm.network :forwarded_port, guest: 8080, host: 8080
    config.vm.network :forwarded_port, guest: 9999, host: 9999
    config.vm.network :forwarded_port, guest: 8777, host: 8777

    # VM resource settings
    config.vm.provider :virtualbox do |vb|
        vb.memory = 12288
        vb.cpus = 4
    end

    # Provisioning
    config.vm.provision :shell, path: "bootstrap.sh"

end
