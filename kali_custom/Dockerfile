FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive

# Crear directorios de trabajo
RUN mkdir -p /root/lab /root/loot

# Usar el CDN oficial de Kali (más estable que el round-robin http.kali.org)
RUN echo "deb http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware" > /etc/apt/sources.list

# Instalar herramientas durante el build
RUN apt-get update && apt-get install -y \
    metasploit-framework \
    nmap \
    netcat-traditional \
    hydra \
    john \
    sqlmap \
    nikto \
    dirb \
    gobuster \
    enum4linux-ng \
    smbclient \
    curl wget git vim nano \
    net-tools iputils-ping dnsutils \
    openssh-client ftp telnet tcpdump \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Inicializar la base de datos de Metasploit durante el build
RUN service postgresql start && msfdb init

WORKDIR /root/lab

CMD ["/bin/bash"]
