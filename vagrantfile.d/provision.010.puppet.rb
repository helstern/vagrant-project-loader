Vagrant.configure(VAGRANTFILE_API_VERSION) { |config|

  environment = $box_configuration.fetch(:environment)
  machine_role = $box_configuration.fetch(:machine_role)

  # sync the library folder
  config.vm.synced_folder "#{MACHINE_PROVISIONER_PATH}", '/puppet'

  if $box_configuration.key? :fileserver_mount_src
    config.vm.synced_folder $box_configuration.fetch(:fileserver_mount_src), '/puppet/fileserver', {}
  end

  config.vm.provision :puppet do |puppet|

    puppet.temp_dir = '/puppet'

    puppet.manifests_path = "#{MACHINE_PROVISIONER_PATH}/puppet/manifests"
    puppet.manifest_file = 'bootstrap.pp'

    #puppet.module_path = ['project-provisioner/puppet/modules', "#{MACHINE_PROVISIONER_PATH}/puppet/modules"]
    # puppet.module_path = [
    #     "#{MACHINE_PROVISIONER_PATH}/puppet/modules"
    # ]

    # hiera
    # puppet.hiera_config_path = "#{MACHINE_PROVISIONER_PATH}/hiera/hiera.yaml"
    # puppet.working_directory = '/puppet'

    # facter
    puppet.facter = {
        :environment      => environment,
        :machine_role     => machine_role,
    }

    # set puppet options
    puppet.options = []
    puppet.options << "--node_name_value=#{machine_role}"
    # hiera
    puppet.options << '--hiera_config=/puppet/hiera/hiera.yaml'

    puppet.options << '--verbose --debug'
    puppet.options << '--ordering=manifest'

    puppet.options << '--manifestdir /puppet/puppet/manifests'
    puppet.options << '--modulepath /puppet/puppet/modules:/etc/puppet/modules'
    puppet.options << '--libdir /puppet/puppet/lib'

    if $box_configuration.key? :fileserver_mount_src
      puppet.options << '--fileserverconfig /puppet/fileserver/conf/fileserver.conf'
    end

  end


}
