#!/bin/bash

# Mise à jour des paquets
sudo apt-get update

# Installation de vsftpd
sudo apt-get install -y vsftpd

# Sauvegarde du fichier de configuration original
sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.orig

# Configuration de base de vsftpd
echo "Écriture de la configuration de base de vsftpd..."
sudo bash -c 'cat << EOF > /etc/vsftpd.conf
listen=YES
anonymous_enable=NO
local_enable=YES
write_enable=YES
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
chroot_local_user=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
pasv_enable=Yes
pasv_min_port=10000
pasv_max_port=10100
user_sub_token=\$USER
local_root=/home/\$USER/ftp
EOF'

# Création d'un répertoire pour les utilisateurs FTP
echo "Création d'un répertoire FTP pour les utilisateurs..."
sudo mkdir -p /home/$USER/ftp
sudo chown nobody:nogroup /home/$USER/ftp
sudo chmod a-w /home/$USER/ftp

# Création d'un répertoire pour le stockage des fichiers
sudo mkdir -p /home/$USER/ftp/files
sudo chown $USER:$USER /home/$USER/ftp/files

# Redémarrage du service vsftpd pour appliquer les changements
sudo systemctl restart vsftpd

echo "Le serveur FTP vsftpd a été installé et configuré."
