# Configuración de Red del Laboratorio

## 🔒 IPs Estáticas Configuradas

El laboratorio usa una **red fija** configurada explícitamente en docker-compose.yml:

```
Red: 172.25.0.0/24
Gateway: 172.25.0.1
```

### Asignación de IPs:

| Máquina | IP Fija | Hostname |
|---------|---------|----------|
| Gateway Docker | 172.25.0.1 | - |
| 🥷 Kali | **172.25.0.10** | kali |
| 🎯 DVWA | **172.25.0.20** | dvwa |
| 💻 Debian | **172.25.0.30** | debian-target |

## ¿Por qué IPs estáticas?

### ❌ **ANTES** (sin configuración):
- Docker asigna IPs aleatorias del pool
- La red puede ser 172.18.x, 172.19.x, 172.25.x, etc.
- Las IPs cambian entre reinicios
- Los comandos de la guía pueden fallar

### ✅ **AHORA** (con IPs estáticas):
- Siempre la misma red: 172.25.0.0/24
- Las IPs nunca cambian
- Los comandos siempre funcionan:
  ```bash
  nmap -sn 172.25.0.0/24  # Siempre válido
  ssh root@172.25.0.30     # Siempre Debian
  ```

## 🔧 Configuración en docker-compose.yml

```yaml
networks:
  labnet:
    driver: bridge
    ipam:
      config:
        - subnet: 172.25.0.0/24
          gateway: 172.25.0.1
```

```yaml
services:
  kali:
    networks:
      labnet:
        ipv4_address: 172.25.0.10
```

## 💡 Ventajas adicionales

1. **Documentación precisa**: Puedes documentar comandos exactos
2. **Scripts consistentes**: Los scripts de ataque siempre funcionan
3. **Debugging fácil**: Sabes exactamente qué IP es cada máquina
4. **Sin sorpresas**: No hay que verificar IPs cada vez

## 🧪 Verificar la configuración

Después de `docker-compose up -d`:

```bash
# Verificar la red
docker network inspect lab-cibersec1_labnet

# Verificar IPs desde Kali
docker exec -it kali_lab hostname -I
# Output: 172.25.0.10
```

## 📝 Notas

- El rango .1-.9 está reservado (Docker usa .1 como gateway)
- Se usan IPs espaciadas (.10, .20, .30) para claridad
- Puedes agregar más máquinas con IPs .40, .50, etc.
