# Laboratorio de Ciberseguridad

Laboratorio Docker con Kali Linux, DVWA y Debian vulnerable para prácticas de pentesting.

## ⚙️ Estructura

- **kali_lab**: Kali Linux para pentesting
- **dvwa_lab**: DVWA (Damn Vulnerable Web Application) - Aplicación web vulnerable en http://localhost:4000
- **debian_target_lab**: Debian con servicios vulnerables (SSH, FTP, Apache, MariaDB)

> **Nota**: DVWA reemplaza Metasploitable2 ya que funciona perfectamente en docker y ofrece excelentes prácticas de vulnerabilidades web (SQL Injection, XSS, CSRF, etc.)

## 🔑 Credenciales

**DVWA:**
- Usuario: `admin`
- Password: `password`

**Debian Target:**
- root: `password123`
- user1: `user123`

## 🚀 Inicio rápido

```bash
# Construir e iniciar el laboratorio
docker-compose up -d --build

# Acceder a Kali
docker exec -it kali_lab bash

# Ver logs
docker-compose logs -f

# Detener el laboratorio
docker-compose down

# Detener y eliminar volúmenes
docker-compose down -v
```

## 🛠️ Instalar herramientas en Kali

Las herramientas se instalan desde el contenedor para evitar problemas de build.

**Desde tu terminal:**
```bash
docker exec -it kali_lab bash
apt-get update && apt-get install -y kali-tools-top10 nmap metasploit-framework hydra john sqlmap nikto
```

O usa el script incluido:
```bash
docker cp install-kali-tools.sh kali_lab:/root/lab/
docker exec -it kali_lab bash /root/lab/install-kali-tools.sh
```

## 🎯 Escaneo y ataque desde Kali

```bash
# Entrar a Kali
docker exec -it kali_lab bash

# Instalar nmap si no está disponible
apt-get update && apt-get install -y nmap

# Escanear la red (IPs fijas configuradas)
nmap -sn 172.25.0.0/24

# Escanear Debian target
nmap -sV -p- debian-target

# Escanear DVWA
nmap -sV -p- dvwa

# Intentar login SSH en Debian (credenciales: root/password123)
ssh root@debian-target

# Escanear vulnerabilidades web en DVWA
nikto -h http://dvwa

# Fuerza bruta SSH (ejemplo educativo)
hydra -l user1 -p user123 ssh://debian-target
```

## 🌐 Acceso a DVWA

DVWA está disponible desde tu navegador:
- **URL**: http://localhost:4000
- **Usuario**: admin
- **Password**: password

**Configuración inicial:**
1. Abre http://localhost:4000
2. Click en "Create / Reset Database"
3. Login con admin/password
4. Cambia el nivel de seguridad en "DVWA Security" (Low/Medium/High)
5. Practica con vulnerabilidades: SQL Injection, XSS, CSRF, File Upload, Command Injection, etc.

## 📚 Herramientas incluidas en Kali

Instala con el script o manualmente:
- Metasploit Framework
- Nmap (escáner de puertos)
- Hydra (fuerza bruta)
- John the Ripper (cracking passwords)
- SQLMap (SQL Injection)
- Nikto (escáner web)
- Gobuster (brute force directorios)
- Y muchas más...

## 💾 Volúmenes persistentes

- `/root/lab`: Directorio de trabajo (persistente)
- `/root/loot`: Para guardar resultados de explotación (persistente)

## 🔒 Red

Todos los contenedores están en la red `labnet` aislada. El único puerto expuesto al host es:
- **4000** → DVWA (web interface)

Los servicios de Debian (SSH, FTP, etc.) solo son accesibles desde dentro de la red del laboratorio (desde Kali).

## ⚠️ Advertencia

Este laboratorio contiene máquinas intencionalmente vulnerables. **NUNCA** expongas estos contenedores a internet o redes públicas. Solo para uso educativo en entornos controlados.


⚠️ Este laboratorio contiene máquinas intencionalmente vulnerables. **NUNCA** expongas estos contenedores a internet o redes públicas.
