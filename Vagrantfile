# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network :private_network, ip: "192.168.50.4"
  config.vm.hostname = "wordpress"
  config.vm.synced_folder "conf/", "/etc/apache2/sites-available/"
  config.vm.synced_folder "wordpress", "/var/www/wordpress"
  config.vm.provision :shell, path: "bootstrap.sh"
end
