#!/bin/bash

# Chemin du répertoire de DVWA
DVWA_DIR="/var/www/html/dvwa"

# Installation des dépendances supplémentaires pour DVWA
sudo apt-get update
sudo apt-get install -y git php-gd php-mysqli

# Clonage du dépôt DVWA depuis GitHub
sudo git clone https://github.com/ethicalhack3r/DVWA.git $DVWA_DIR

# Attribution des permissions nécessaires au répertoire DVWA
sudo chown -R www-data:www-data $DVWA_DIR
sudo chmod -R 755 $DVWA_DIR

# Configuration du fichier de configuration de DVWA
sudo cp $DVWA_DIR/config/config.inc.php.dist $DVWA_DIR/config/config.inc.php
sudo sed -i "s/'db_user' => 'admin'/'db_user' => 'dvwa_user'/" $DVWA_DIR/config/config.inc.php
sudo sed -i "s/'db_password' => 'password'/'db_password' => 'dvwa_password'/" $DVWA_DIR/config/config.inc.php
sudo sed -i "s/'db_database' => 'dvwa'/'db_database' => 'dvwa'/" $DVWA_DIR/config/config.inc.php
sudo sed -i "s/$_DVWA[ 'recaptcha_public_key' ] = '';/$_DVWA[ 'recaptcha_public_key' ] = 'votre_clé_publique';/" $DVWA_DIR/config/config.inc.php
sudo sed -i "s/$_DVWA[ 'recaptcha_private_key' ] = '';/$_DVWA[ 'recaptcha_private_key' ] = 'votre_clé_privée';/" $DVWA_DIR/config/config.inc.php

# Redémarrage du serveur Apache pour appliquer les changements
sudo systemctl restart apache2

echo "Installation et configuration de DVWA terminées!"
