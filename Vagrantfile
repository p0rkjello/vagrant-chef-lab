# -*- mode: ruby -*-
# vi: set ft=ruby :
# frozen_string_literal: true

iso_path = 'C:\Program Files\Oracle\VirtualBox\VBoxGuestAdditions.iso'
domainname = 'dev.local'

servers = [
  { hostname: 'gitlab',
    ip:       '192.168.50.10',
    box:      'centos-7.7-x86_64',
    memory:   1024,
    cpu:      1,
    gui:      false,
    clone:    true,
    script:   'scripts/gitlab.sh',
    start:    true,
  },
  { hostname: 'habitat',
    ip:       '192.168.50.11',
    box:      'centos-7.7-x86_64',
    memory:   2048,
    cpu:      2,
    gui:      false,
    clone:    true,
    disksize: '100GB',
    script:   'scripts/habitat.sh',
    start:    true,
  },
  { hostname: 'workstation',
    ip:       '192.168.50.12',
    box:      'centos-7.7-x86_64',
    memory:   1024,
    cpu:      1,
    gui:      false,
    clone:    true,
    script:   'scripts/workstation.sh',
    start:    false,
  },
  { hostname: 'node1',
    ip:       '192.168.50.13',
    box:      'centos-7.7-x86_64',
    memory:   1024,
    cpu:      1,
    gui:      false,
    clone:    true,
    script:   'scripts/node.sh',
    start:    false,
  },
  { hostname: 'node2',
    ip:       '192.168.50.14',
    box:      'centos-7.7-x86_64',
    memory:   1024,
    cpu:      1,
    gui:      false,
    clone:    true,
    script:   'scripts/node.sh',
    start:    false,
  },
]

Vagrant.configure('2') do |config|
  # Required plugins
  config.vagrant.plugins = %w(vagrant-vbguest vagrant-hostsupdater vagrant-disksize)
  config.vbguest.iso_path = iso_path

  servers.each do |server|
    config.vm.define server[:hostname], autostart: server[:start] do |node|
      node.vm.box = server[:box]
      node.vm.hostname = server[:hostname]
      node.vm.network 'private_network', ip: server[:ip], nic_type: 'virtio'

      if server.key?(:disksize)
        node.disksize.size = server[:disksize]
      end

      node.vm.provider 'virtualbox' do |v|
        v.gui = server[:gui]
        v.linked_clone = server[:clone]
        v.name = server[:hostname]
        v.memory = server[:memory]
        v.cpus = server[:cpu]
        # ICH9 chipset, SSD, Host I/O Cache
        v.customize [
        'modifyvm', :id,
        '--chipset', 'ich9'
        ]
        v.customize [
        'storageattach', :id,
        '--storagectl', 'SATA Controller',
        '--port', '0',
        '--nonrotational', 'on'
        ]
        v.customize [
        'storagectl', :id,
        '--name', 'SATA Controller',
        '--hostiocache', 'on'
        ]
      end

      if server.key?(:disksize)
        node.vm.provision 'shell', privileged: false, path: 'scripts/resize_lvm.sh'
      end
      if server.key?(:script)
        node.vm.provision 'shell', privileged: false, path: server[:script]
      end
      fqdn = "#{server[:hostname]}.#{domainname}"
      node.hostsupdater.aliases = [fqdn]
    end
  end
  config.vm.provision 'shell', privileged: false, path: 'scripts/hosts.sh'
end
