Vagrant.configure(VAGRANTFILE_API_VERSION) { |config|

  config.vm.provision :shell do |shell|
    shell.path = "#{MACHINE_PROVISIONER_PATH}/shell/0001.sync_packages.sh"
  end

}

Vagrant.configure(VAGRANTFILE_API_VERSION) { |config|

  config.vm.provision :shell do |shell|
    shell.path = "#{MACHINE_PROVISIONER_PATH}/shell/0002.puppet_install.sh"
    shell.args = ['--puppet_source /puppet']
  end

}
