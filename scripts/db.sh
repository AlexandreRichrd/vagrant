#!/bin/bash

## Install MariaDB for DVWA

IP=$(hostname -I | awk '{print $2}')
APT_OPT="-o Dpkg::Progress-Fancy=\"0\" -q -y"
LOG_FILE="/vagrant/logs/install_bdd.log"
DEBIAN_FRONTEND="noninteractive"

# Configuration de la base de données pour DVWA
DBNAME="dvwa"
DBUSER="dvwa_user"
DBPASSWD="dvwa_password"
# Fichier SQL pour initialiser la base de données DVWA
DBFILE="files/dvwa.sql"

echo "START - install MariaDB - "$IP

echo "=> [1]: Install required packages ..."
DEBIAN_FRONTEND=noninteractive
apt-get install -o Dpkg::Progress-Fancy="0" -q -y \
	mariadb-server \
	mariadb-client \
   >> $LOG_FILE 2>&1

echo "=> [2]: Configuration de la base de données"
if [ -n "$DBNAME" ] && [ -n "$DBUSER" ] && [ -n "$DBPASSWD" ] ;then
  mysql -e "CREATE DATABASE $DBNAME" \
  >> $LOG_FILE 2>&1
  mysql -e "grant all privileges on $DBNAME.* to '$DBUSER'@'localhost' identified by '$DBPASSWD'" \
  >> $LOG_FILE 2>&1
fi

echo "=> [3]: Importation de la base de données DVWA"
if [ -f "$DBFILE" ] ;then
  mysql $DBNAME < /vagrant/$DBFILE \
  >> $LOG_FILE 2>&1
fi

echo "END - install MariaDB for DVWA"
