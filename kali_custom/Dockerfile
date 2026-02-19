FROM kalilinux/kali-rolling

# Variables de entorno
ENV DEBIAN_FRONTEND=noninteractive

# Crear directorios de trabajo
RUN mkdir -p /root/lab /root/loot

# Script para instalar herramientas al primer arranque
RUN echo '#!/bin/bash\n\
echo "=== Instalando herramientas de pentesting ==="\n\
apt-get update\n\
apt-get install -y kali-tools-top10 metasploit-framework nmap netcat-traditional \\\n\
    hydra john sqlmap nikto dirb gobuster enum4linux smbclient \\\n\
    curl wget git vim nano net-tools iputils-ping dnsutils \\\n\
    openssh-client ftp telnet tcpdump 2>/dev/null || echo "Algunas herramientas no pudieron instalarse"\n\
echo "=== Instalación completada ==="\n\
service postgresql start\n\
msfdb init 2>/dev/null || echo "Metasploit DB ya inicializada"\n\
cd /root/lab\n\
tail -f /dev/null' > /root/setup_and_run.sh && \
    chmod +x /root/setup_and_run.sh

WORKDIR /root/lab

# Las herramientas se instalarán al arrancar el contenedor
CMD ["/bin/bash", "/root/setup_and_run.sh"]
