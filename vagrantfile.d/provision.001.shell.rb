Vagrant.configure(VAGRANTFILE_API_VERSION) { |config|

  config.vm.provision :shell do |shell|
    shell.path = "#{MACHINE_PROVISIONER_PATH}/shell/puppet_install.sh"
    shell.args = ['--puppet_source /puppet']
  end

}
