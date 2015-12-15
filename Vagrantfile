# vim: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'ShadowKoBolt/ubuntu-precise'

  config.vm.hostname = 'seatpicker'
  config.vm.network :private_network, ip: '10.0.33.33'
  config.vm.network 'forwarded_port', guest: 3000, host: 5347

  config.vm.synced_folder '~', '/home/master'
  config.vm.synced_folder '.', '/home/vagrant/source', nfs: true

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--cpus', '1', '--memory', 1024]
  end

  config.vm.provision :ansible do |ansible|
    ansible.playbook = 'playbook.yml'
  end
end
