# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    config.vm.box = "chavinje/fr-bull-64"
  
    # Configuration du pare-feu (Firewall)

    config.vm.define "firewall" do |firewall|
      firewall.vm.box = "chavinje/fr-bull-64"
        firewall.vm.network "private_network", ip: "192.168.56.11"
        firewall.vm.provision "shell", inline: <<-SHELL
        sudo -i
        sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config    
        sleep 3
        service ssh restart
        SHELL
    end
  
    # Configuration du poste victime (Victim)
    config.vm.define "victim" do |victim|
      victim.vm.box = "chavinje/fr-bull-64"
      victim.vm.hostname="victim"
      # Configuration des interfaces réseau
      
      victim.vm.network "private_network", ip: "192.168.56.22"
      
      victim.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--name", "victim"]
        v.customize ["modifyvm", :id, "--groups", "/S7-projet"]
        v.customize ["modifyvm", :id, "--cpus", "1"]
        v.customize ["modifyvm", :id, "--memory", 1024]
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
      end
      victim.vm.provision "shell", inline: <<-SHELL
        sudo -i
        sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config    
        sleep 3
        service ssh restart
        SHELL
        victim.vm.provision "shell", path: "scripts/apache.sh"
        victim.vm.provision "shell", path: "scripts/db.sh"
        victim.vm.provision "shell", path: "scripts/dvwa.sh"
        victim.vm.provision "shell", path: "scripts/telnet.sh"
        victim.vm.provision "shell", path: "scripts/ftp.sh"
    end
  
    # Configuration du poste attaquant (Attack)
    config.vm.define "attack" do |attack|
      attack.vm.box = "chavinje/fr-bull-64"
        attack.vm.network "private_network", ip: "192.168.56.33"
        attack.vm.provision "shell", inline: <<-SHELL
        sudo -i
        sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config    
        sleep 3
        service ssh restart
        SHELL
    end
  
  end
  