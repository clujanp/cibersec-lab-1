FROM debian:11

# Actualizar sistema
RUN apt-get update && apt-get upgrade -y

# Instalar servicios vulnerables y herramientas básicas
RUN apt-get install -y \
    openssh-server \
    vsftpd \
    telnetd \
    apache2 \
    mariadb-server \
    php \
    php-mysql \
    net-tools \
    iputils-ping \
    nano \
    curl \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configurar SSH para permitir autenticación con contraseña
RUN mkdir /var/run/sshd && \
    echo 'root:password123' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Crear usuario vulnerable
RUN useradd -m -s /bin/bash user1 && \
    echo 'user1:user123' | chpasswd

# Configurar servicios para iniciar automáticamente
RUN echo '#!/bin/bash\n\
service ssh start\n\
service vsftpd start\n\
service apache2 start\n\
tail -f /dev/null' > /start.sh && \
    chmod +x /start.sh

EXPOSE 21 22 80 3306

CMD ["/start.sh"]
