#!/bin/bash
# Script para instalar herramientas en Kali cuando el repositorio esté disponible

echo "=== Actualizando repositorios de Kali ==="
apt-get clean
apt-get update

echo "=== Instalando herramientas básicas del sistema ==="
apt-get install -y curl wget git vim nano net-tools iputils-ping dnsutils procps

echo "=== Instalando herramientas principales de pentesting ==="
apt-get install -y \
    kali-tools-top10 \
    metasploit-framework \
    nmap \
    netcat-traditional \
    hydra \
    john \
    sqlmap \
    nikto \
    dirb \
    gobuster \
    enum4linux \
    smbclient \
    openssh-client \
    ftp \
    telnet \
    tcpdump

echo "=== Inicializando base de datos de Metasploit ==="
service postgresql start
msfdb init
service postgresql stop

echo "=== ✅ Instalación completada ==="
echo ""
echo "Herramientas principales instaladas:"
echo " - Metasploit Framework"
echo " - Nmap" 
echo " - Hydra"
echo " - John the Ripper"
echo " - SQLMap"
echo " - Nikto"
echo " - Y muchas más..."
echo ""
echo "Para usar Metasploit: service postgresql start && msfconsole"
