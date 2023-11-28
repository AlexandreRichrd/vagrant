#!/bin/bash

# Mise à jour des paquets et installation de telnetd
sudo apt-get update
sudo apt-get install -y telnetd

# Activation et démarrage du service telnet
sudo systemctl enable inetd
sudo systemctl start inetd

echo "Le serveur Telnet a été installé et démarré."
