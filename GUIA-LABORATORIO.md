# 🎯 Laboratorio de Ciberseguridad - Guía Visual

## 🔍 ¿Qué es esto?

Un entorno seguro de práctica donde puedes **aprender hacking ético** sin romper nada real. Como un simulador de vuelo, pero para hackers.

```
┌─────────────────────────────────────────────────────┐
│                TU COMPUTADORA                       │
│                                                     │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐       │
│  │  🥷 Kali │───▶│ 🎯 DVWA  │    │ 💻 Debian│       │
│  │  (Atacar)│    │ (Víctima)│    │ (Víctima)│       │
│  └──────────┘    └──────────┘    └──────────┘       │
│                                                     │
│  Red aislada - Nada sale de aquí                    │
└─────────────────────────────────────────────────────┘
```

---

## 🚀 Paso 1: Arrancar el Laboratorio

```bash
docker-compose up -d
```

**¿Qué hace esto?** Enciende 3 computadoras virtuales:

| Máquina | Rol | Para qué sirve |
|---------|-----|----------------|
| 🥷 **Kali** | El atacante | Desde aquí lanzas los ataques |
| 🎯 **DVWA** | Sitio web vulnerable | Hackeo WEB: SQL Injection, XSS, File Upload |
| 💻 **Debian** | Servidor vulnerable | Hackeo SISTEMAS: SSH, FTP, escalación de privilegios |

**¿Por qué dos víctimas?**
- **DVWA** → Aprende a hackear aplicaciones web
- **Debian** → Aprende a hackear servidores e infraestructura

**Tiempo de arranque:** ~30 segundos ⏱️

---

## 🌐 Paso 2: Acceder a DVWA (La Víctima Web)

1. Abre tu navegador Chrome/Firefox
2. Ve a: **http://localhost:4000**
3. Login:
   - Usuario: `admin`
   - Contraseña: `password`
4. Haz click en **"Create / Reset Database"**
5. Vuelve a hacer login

### 🎮 ¿Qué puedes hacer aquí?

DVWA es una aplicación web **intencionalmente vulnerable**. Tiene 10+ ejercicios:

- 💉 **SQL Injection** → Robar datos de la base de datos
- 🔐 **Brute Force** → Adivinar contraseñas
- 📤 **File Upload** → Subir archivos maliciosos
- 💬 **XSS** → Inyectar código JavaScript
- Y más...

**Dificultad:** Ajustable (Low → Medium → High)

---

## 💻 Servidor Debian (La Víctima de Infraestructura)

**No tiene interfaz web** - Se hackea desde la terminal de Kali.

### 🔓 Servicios vulnerables que corren:

| Servicio | Puerto | ¿Para qué sirve practicar? |
|----------|--------|----------------------------|
| **SSH** | 22 | Fuerza bruta de contraseñas, acceso remoto |
| **FTP** | 21 | Subir/bajar archivos, anonymous login |
| **Apache** | 80 | Página web simple (complemento a DVWA) |
| **MySQL** | 3306 | Conexión directa a base de datos |

### 🎯 ¿Qué puedes hacer con Debian?

1. **Practicar fuerza bruta** → Adivinar contraseñas SSH con Hydra
2. **Acceso remoto** → Entrar como si fueras un administrador
3. **Exploración de sistemas Linux** → Navegar archivos, buscar datos
4. **Escalación de privilegios** → Convertir user1 en root
5. **Explotar servicios de red** → FTP, MySQL, etc.

**Credenciales:**
- root / password123
- user1 / user123

---

## 🥷 Paso 3: Entrar a Kali (El Atacante)

```bash
docker exec -it kali_lab bash
```

**¡Ya estás dentro!** Verás algo así:
```
┌──(root㉿kali)-[/root/lab]
└─#
```

### 🛠️ Instalar herramientas (primera vez):

```bash
apt-get update
apt-get install -y nmap hydra sqlmap nikto
```

---

## 🎯 Ataques Básicos que Puedes Hacer

### 1️⃣ **Escanear la red** (Ver qué hay conectado)

```bash
nmap -sn 172.0.0.0/16
```

**Resultado:** Verás las IPs de DVWA y Debian

---

### 2️⃣ **Escanear puertos** (¿Qué servicios corren?)

```bash
# Escanear DVWA
nmap -sV dvwa

# Escanear Debian
nmap -sV debian-target
```

**Resultado:** Lista de puertos abiertos (80=web, 22=SSH, 21=FTP...)

---

### 3️⃣ **Entrar por SSH a Debian** (Acceso remoto)

```bash
ssh root@debian-target
# Contraseña: password123
```

**¡Felicidades!** Entraste al servidor 🎉

**Ahora puedes:**
```bash
# Ver quién está conectado
whoami

# Listar archivos
ls -la

# Ver procesos corriendo
ps aux

# Buscar archivos con contraseñas
grep -r "password" /home/

# Salir
exit
```

---

### 4️⃣ **Fuerza Bruta SSH en Debian** (Adivinar contraseñas)

```bash
# Probar 1 contraseña
hydra -l user1 -p user123 ssh://debian-target

# Probar con lista de contraseñas (ejemplo)
hydra -l root -P passwords.txt ssh://debian-target
```

**¿Qué hace?** Prueba miles de combinaciones hasta encontrar la correcta

**Tiempo:** Depende de la lista de contraseñas (puede tardar minutos/horas)

---

### 5️⃣ **Escanear vulnerabilidades web**

```bash
# Escanear DVWA
nikto -h http://dvwa

# Escanear web de Debian
nikto -h http://debian-target
```

**Resultado:** Lista de problemas de seguridad en sitios web

---

### 6️⃣ **Explorar servicios adicionales de Debian**

```bash
# Conectar a FTP
ftp debian-target
# Usuario: root / password123

# Probar conexión MySQL
mysql -h debian-target -u root -p
# (Si MySQL está disponible desde red)

# Ver página web de Debian
curl http://debian-target
```

---

## 🆚 DVWA vs Debian - ¿Cuál usar para qué?

| Tipo de Práctica | Usa esto | Herramientas |
|------------------|----------|--------------|
| Hackeo de páginas web | 🎯 **DVWA** | Navegador, Burp Suite, SQLMap |
| SQL Injection | 🎯 **DVWA** | SQLMap, manual en navegador |
| XSS / CSRF | 🎯 **DVWA** | Navegador + JavaScript |
| File Upload malicioso | 🎯 **DVWA** | Navegador + archivos PHP |
| Fuerza bruta SSH/FTP | 💻 **Debian** | Hydra, Medusa |
| Acceso remoto a servidores | 💻 **Debian** | SSH, Telnet |
| Escaneo de puertos | 💻 **Debian** | Nmap, Netcat |
| Exploración de sistemas Linux | 💻 **Debian** | Comandos bash una vez dentro |
| Escalación de privilegios | 💻 **Debian** | Exploits locales, sudo -l |

**Resumen simple:**
- 🎯 **DVWA** = Ataques desde el **navegador**
- 💻 **Debian** = Ataques desde la **terminal/consola**

---

## 📊 Resumen Visual del Flujo

```
TÚ 
 │
 ├─▶ Navegador ─▶ http://localhost:4000 ──▶ 🎯 DVWA
 │                   (Hackear web: SQL Injection, XSS, etc.)
 │
 └─▶ Terminal ─▶ docker exec ──▶ 🥷 Kali
                                  │
                                  ├─▶ nmap ──────▶ Escanear DVWA + Debian
                                  ├─▶ hydra ─────▶ Fuerza bruta SSH (Debian)
                                  ├─▶ nikto ─────▶ Buscar fallos web (ambos)
                                  ├─▶ ssh ───────▶ Entrar a 💻 Debian
                                  ├─▶ ftp ───────▶ Conectar FTP (Debian)
                                  └─▶ sqlmap ────▶ SQL Injection (DVWA)

💡 DVWA = Navegador | Debian = Terminal
```

---

## 🛑 Apagar el Laboratorio

```bash
# Apagar y guardar datos
docker-compose down

# Apagar y borrar todo
docker-compose down -v
```

---

## 🔑 Credenciales - Cheat Sheet

| Sistema | Usuario | Contraseña |
|---------|---------|------------|
| 🎯 DVWA | `admin` | `password` |
| 💻 Debian (root) | `root` | `password123` |
| 💻 Debian (user) | `user1` | `user123` |

---

## ⚠️ Reglas Importantes

### ✅ Puedes:
- Atacar **TODO** dentro del laboratorio
- Romper, probar, experimentar
- Aprender sin miedo

### ❌ NO debes:
- Usar estas técnicas en sitios reales sin permiso
- Exponer este laboratorio a internet
- Compartir en redes públicas

---

## 🎓 Conceptos Básicos

| Término | Significado Simple |
|---------|-------------------|
| **Nmap** | Escáner de puertos (como un radar) |
| **Hydra** | Robot para adivinar contraseñas |
| **SSH** | Conexión remota a un servidor |
| **SQL Injection** | Meter comandos maliciosos en formularios |
| **XSS** | Inyectar código en páginas web |
| **Nikto** | Detector de problemas en sitios web |

---

## 🎯 Retos Sugeridos (De fácil a difícil)

### Nivel 1: Reconocimiento 🔍
- [ ] Escanear la red y encontrar las 2 víctimas (DVWA + Debian)
- [ ] Listar todos los puertos abiertos de Debian
- [ ] Identificar versiones de servicios (SSH, FTP, Apache)
- [ ] Descubrir qué sistema operativo usa cada máquina

### Nivel 2: Acceso Básico 🔓
**En Debian:**
- [ ] Entrar por SSH con las credenciales dadas
- [ ] Explorar el sistema de archivos
- [ ] Listar usuarios del sistema (`cat /etc/passwd`)

**En DVWA:**
- [ ] Hacer login en DVWA
- [ ] Configurar la base de datos
- [ ] Cambiar nivel de seguridad a "Low"

### Nivel 3: Explotación Web (DVWA) 🌐
- [ ] SQL Injection nivel "Low" - Robar datos
- [ ] Brute Force - Adivinar password de admin
- [ ] File Upload - Subir un archivo PHP
- [ ] Command Injection - Ejecutar comandos del sistema
- [ ] XSS Reflected - Inyectar JavaScript

### Nivel 4: Explotación de Infraestructura (Debian) 💻
- [ ] Usar Hydra para fuerza bruta SSH
- [ ] Conectarse por FTP y subir un archivo
- [ ] Buscar archivos sensibles en /home/
- [ ] Intentar escalar privilegios de user1 a root
- [ ] Ver logs del sistema (`/var/log/`)

### Nivel 5: Avanzado 🚀
**DVWA nivel Medium/High:**
- [ ] SQL Injection en nivel "Medium"
- [ ] XSS Stored - Inyección persistente
- [ ] CSRF - Falsificación de peticiones
- [ ] File Inclusion - Incluir archivos remotos

**Debian + Kali combinados:**
- [ ] Crear un script de automatización de ataques
- [ ] Pivotar: usar Debian como puente a otra red
- [ ] Instalar una backdoor en Debian
- [ ] Borrar rastros de tus ataques en los logs

---

## 📚 Recursos de Aprendizaje

- **DVWA tiene tutoriales incluidos** en cada ejercicio
- Cambia el nivel de seguridad: `DVWA Security` → Low/Medium/High
- Google: "DVWA [nombre del ejercicio] tutorial"

---

## 🆘 Problemas Comunes

**❓ No puedo instalar herramientas en Kali**
```bash
apt-get update
apt-get install -y <nombre-herramienta>
```

**❓ "Connection refused" al conectar**
- Verifica que los contenedores estén corriendo: `docker ps`
- Reinicia: `docker-compose restart`

**❓ DVWA no carga**
- Ve a: http://localhost:4000
- Recrea la base de datos: Click en "Setup" → "Create Database"

**❓ Olvidé las contraseñas**
- Revisa la sección 🔑 Credenciales arriba

---

## 🎉 ¡Todo listo!

Ya tienes un laboratorio profesional de ciberseguridad. 

**Siguiente paso:** Abre http://localhost:4000 y empieza a hackear de forma ética 🚀

```
Happy Hacking! 🥷💻🔒
```
