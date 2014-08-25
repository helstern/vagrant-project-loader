
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = 'test-automation_virtualbox'
  config.vm.box_url = 'file:///' + MACHINE_PROVISIONER_PATH + '/box/server-ubuntu-12.04_virtualbox.box'

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = 'http://domain.com/path/to/above.box'

  # Set the hostname of the machine
  config.vm.hostname = $box_configuration.fetch(:hostname)

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing 'localhost:8080' will access port 80 on the guest machine.
  # config.vm.network :forwarded_port, guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: '192.168.33.10', auto_config: true, type: "dhcp"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network, type: "dhcp", auto_config: false

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder '../data', '/vagrant_data'
  $box_configuration.fetch(:additional_sync_folders).each do |opts|
    config.vm.synced_folder opts[:hostpath], opts[:guestpath], opts.reject{|key,value| [:hostpath, :guestpath].include?(key)}
  end

  # Configure ssh access
  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true
end