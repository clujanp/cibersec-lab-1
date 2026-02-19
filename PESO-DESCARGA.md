# 📦 Peso del Laboratorio - Descarga y Almacenamiento

## 💾 Primera vez: `docker-compose up --build`

### Imágenes base que se descargan:

| Imagen | Tamaño Comprimido | Tamaño Descomprimido | Uso |
|--------|-------------------|----------------------|-----|
| 🐧 **debian:11** | ~25 MB | ~120 MB | Base para Debian target |
| 🥷 **kalilinux/kali-rolling** | ~50 MB | ~140 MB | Base para Kali |
| 🎯 **vulnerables/web-dvwa** | ~270 MB | ~710 MB | DVWA completo |
| **TOTAL DESCARGA** | **~345 MB** | **~970 MB** | - |

### Build de imágenes personalizadas:

| Contenedor | Base | Paquetes adicionales | Tamaño Final |
|-----------|------|---------------------|--------------|
| **debian_target** | debian:11 (120 MB) | SSH, FTP, Apache, MariaDB, PHP (~475 MB) | **~595 MB** |
| **kali** | kalilinux/kali (140 MB) | Script de instalación (~2 MB) | **~142 MB** |
| **dvwa** | (pre-construido) | - | **~712 MB** |
| **TOTAL EN DISCO** | - | - | **~1.45 GB** |

---

## 📊 Resumen de Consumo

### 🌐 Descarga desde Internet (primera vez):
```
Datos a descargar: ~345 MB
Tiempo estimado:
  - 10 Mbps: ~5 minutos
  - 50 Mbps: ~1 minuto
  - 100 Mbps: ~30 segundos
```

### 💽 Espacio en disco total:
```
Imágenes Docker: ~1.45 GB
Volúmenes (datos): ~10-50 MB (crece con el uso)
TOTAL: ~1.5 GB
```

### ⏱️ Tiempo de build (primera vez):
```
debian_target: ~2-3 minutos (instala muchos paquetes)
kali: ~30 segundos (solo script)
dvwa: 0 segundos (imagen lista)
TOTAL: ~3-4 minutos
```

---

## 🔄 Siguientes veces

Una vez construido:
- **No descarga nada** (imágenes en caché)
- **Build instantáneo** (usa cache de Docker)
- **Arranque rápido**: ~5-10 segundos

```bash
docker-compose up -d
# ✅ Listo en segundos
```

---

## 🗑️ Limpieza de espacio

### Ver espacio usado:
```bash
docker system df
```

### Limpiar imágenes sin usar:
```bash
# Solo imágenes no usadas
docker image prune

# TODO (cuidado!)
docker system prune -a --volumes
```

### Eliminar solo el laboratorio:
```bash
# Contenedores y red
docker-compose down

# + Volúmenes
docker-compose down -v

# + Imágenes
docker-compose down --rmi all -v
```

**Liberas:** ~1.5 GB

---

## 💡 Optimizaciones realizadas

✅ **Imagen de Kali ligera**
- No pre-instala herramientas (140 MB vs varios GB)
- Script instala bajo demanda

✅ **Multi-stage avoided en Debian**
- Build directo más eficiente

✅ **.dockerignore configurado**
- Evita copiar archivos innecesarios

---

## 📈 Comparativa con alternativas

| Solución | Descarga | Disco | Tiempo |
|----------|----------|-------|--------|
| **Este Lab** | ~345 MB | ~1.5 GB | ~4 min |
| VM Kali completa | ~3 GB | ~20 GB | ~20 min |
| Metasploitable VM | ~800 MB | ~5 GB | ~10 min |
| VirtualBox setup manual | ~5 GB | ~30 GB | ~1 hora |

**🚀 Este laboratorio es 10-20x más ligero que VMs tradicionales**

---

## 🔍 Verificar en tu sistema

```bash
# Ver imágenes del lab
docker images | grep -E "(lab-cibersec|vulnerables|kalilinux|debian.*11)"

# Ver espacio total usado por Docker
docker system df

# Ver solo este proyecto
docker-compose images
```

---

## ❓ FAQ

**¿Por qué Kali pesa solo 142 MB?**
- Es la imagen base sin herramientas
- Las herramientas se instalan al arrancar (opcional)
- Si instalas todo: +500 MB → ~650 MB total

**¿Puedo pre-instalar herramientas en Kali?**
- Sí, descomenta los RUN en `kali_custom/Dockerfile`
- Build será más lento (~10-15 min)
- Imagen final: ~1.5 GB

**¿Los volúmenes ocupan mucho?**
- Inicialmente: ~10 MB
- Después de usar: ~50-200 MB
- Stores: exploits, resultados, logs
