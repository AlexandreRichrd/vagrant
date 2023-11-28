#!/bin/bash

# Mise à jour des paquets
sudo apt-get update

# Installation d'Apache2
sudo apt-get install apache2 -y

# Installation de PHP et des modules nécessaires
sudo apt-get install php libapache2-mod-php php-mysql -y

# Création du répertoire pour DVWA
sudo mkdir -p /var/www/html/dvwa

# Attribuer les permissions appropriées
sudo chown -R $USER:$USER /var/www/html/dvwa
sudo chmod -R 755 /var/www/html

# Création d'un nouveau fichier de configuration VirtualHost
sudo bash -c 'cat << EOF > /etc/apache2/sites-available/dvwa.conf
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html/dvwa
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF'

# Activation du nouveau site
sudo a2ensite dvwa.conf

# Désactivation du site par défaut
sudo a2dissite 000-default.conf

# Activation du module rewrite
sudo a2enmod rewrite

# Redémarrage d'Apache pour appliquer les changements
sudo systemctl restart apache2

echo "Configuration d'Apache avec DVWA terminée!"
