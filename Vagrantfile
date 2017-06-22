# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    # Ubuntu 14.04 LTS
    config.vm.box = "ubuntu/trusty64"

    # VM resource settings
    config.vm.provider :virtualbox do |vb|
        vb.memory = 8192
        vb.cpus = 2
    end

    config.vm.synced_folder "~/.aws", "/home/vagrant/.aws"

    # Provisioning
    # Ansible is installed automatically by Vagrant.
    config.vm.provision "ansible_local" do |ansible|
        ansible.sudo = true
        ansible.playbook = "ansible/playbook.yml"
        ansible.galaxy_role_file = "ansible/roles.yml"
        ansible.galaxy_roles_path = "ansible/roles"
        ansible.groups = {
            "all" => ["default"],
            "all:vars" => {"terraform_version" => "0.9.6",
                           "awscli_version"    => "1.11.*",
                           "aws_profile"       => "geotrellis-site"}
        }
    end

    config.vm.provision "shell" do |s|
        s.path = 'vagrant/cd_shared_folder.sh'
        s.args = "/vagrant"
    end

end
