# 🚀 docker_loadbalancers_automation

🇺🇸 [English](README.md)

Entorno de automatización en contenedor para **Load Balancers y Application Delivery Controllers (ADC) multi-vendor**.

**F5 Networks BIG-IP · A10 Networks Thunder / ACOS · NetScaler ADC**

Este proyecto sigue el mismo enfoque de automatización en contenedores utilizado en:

- [docker_network_automation](https://github.com/andersonmavi30/docker_network_automation) — Network Automation
- [docker_firewall_automation](https://github.com/andersonmavi30/docker_firewall_automation) — Firewall Automation

El objetivo es proporcionar un entorno Docker reproducible con Python, Ansible y herramientas específicas de cada fabricante para la administración de ADC y balanceadores de carga.

---

## 🎯 Objetivo del proyecto

Este repositorio empaqueta dentro de una sola imagen Docker las dependencias necesarias para trabajar con múltiples plataformas de Load Balancer / ADC.

La implementación actual proporciona:

- Rocky Linux 10 como base del contenedor
- Python 3 y pip
- Ansible Core
- SDKs Python específicos por fabricante cuando están disponibles
- Colecciones Ansible específicas por fabricante
- Librerías HTTP/REST genéricas
- Utilidades de cliente SSH
- Un modo de contenedor persistente para usarlo como workspace o jumpbox de automatización

Esto mantiene las herramientas de automatización aisladas del sistema operativo host y facilita reproducir el mismo entorno entre laboratorios y sistemas de desarrollo.

---

## ⚖️ Plataformas soportadas

| Fabricante | Plataforma | Herramientas actuales de automatización |
|---|---|---|
| **F5 Networks** | BIG-IP / LTM | `f5-sdk`, `f5networks.f5_modules`, APIs REST |
| **A10 Networks** | Thunder ADC / ACOS | `acos-client`, `a10.acos_axapi`, aXAPI |
| **NetScaler** | NetScaler ADC | `netscaler.adc`, flujos REST/NITRO |

---

## 🧱 Base del contenedor

La imagen utiliza actualmente:

```text
Rocky Linux 10
```

El directorio de trabajo dentro del contenedor es:

```text
/automation
```

El Dockerfile instala los siguientes paquetes del sistema:

```text
python3
python3-pip
git
openssh-clients
sshpass
```

El comando por defecto del contenedor es:

```text
sleep infinity
```

Esto permite mantener el contenedor en ejecución y utilizarlo como entorno persistente de automatización.

---

## 🐍 Stack de automatización Python

El `requirements.txt` actual instala:

| Paquete | Propósito |
|---|---|
| `ansible-core` | Motor principal de automatización Ansible |
| `requests` | Solicitudes HTTP/REST genéricas |
| `urllib3` | Manejo de conexiones HTTP/TLS |
| `f5-sdk` | SDK Python para automatización de F5 BIG-IP |
| `acos-client>=2.9.0` | Cliente Python para A10 ACOS / aXAPI |

Estas dependencias permiten tanto acceso genérico por API como automatización específica por fabricante.

---

## 🤖 Colecciones Ansible

El `collections.yml` actual instala tres colecciones de fabricante:

```yaml
collections:
  - name: f5networks.f5_modules
  - name: a10.acos_axapi
  - name: netscaler.adc
```

### F5 Networks BIG-IP

```text
f5networks.f5_modules
```

Pensada para automatizar objetos y tareas operativas de BIG-IP mediante Ansible.

### A10 Networks Thunder / ACOS

```text
a10.acos_axapi
```

Proporciona automatización Ansible para plataformas A10 ACOS mediante flujos basados en aXAPI.

### NetScaler ADC

```text
netscaler.adc
```

Proporciona módulos Ansible para configuración y administración de NetScaler ADC.

---

## 🗂️ Estructura actual del repositorio

```text
docker_loadbalancers_automation/
│
├── Dockerfile
├── requirements.txt
├── collections.yml
├── README.md
├── README.es.md
└── LICENSE
```

### `Dockerfile`

Construye el entorno de automatización basado en Rocky Linux 10, instala Python y dependencias del sistema, instala los paquetes Python desde `requirements.txt` y luego las colecciones Ansible desde `collections.yml`.

### `requirements.txt`

Define las dependencias Python y de automatización utilizadas dentro de la imagen.

### `collections.yml`

Define las colecciones Ansible de F5 Networks, A10 Networks y NetScaler instaladas durante el build de Docker.

---

## ⚡ Construir la imagen

Desde la raíz del repositorio:

```bash
docker build -t docker_loadbalancers_automation .
```

Qué hace el comando:

- `docker build` — construye una imagen Docker a partir del Dockerfile.
- `-t docker_loadbalancers_automation` — asigna un nombre/tag local a la imagen.
- `.` — utiliza el directorio actual como contexto de construcción.

---

## 🚀 Ejecutar el contenedor

### Contenedor persistente de automatización

```bash
docker run -d \
  --name lb-automation \
  docker_loadbalancers_automation
```

Luego entra al contenedor:

```bash
docker exec -it lb-automation bash
```

Como el Dockerfile utiliza `sleep infinity`, el contenedor permanece disponible para trabajar hasta que sea detenido.

### Contenedor interactivo temporal

```bash
docker run --rm -it docker_loadbalancers_automation bash
```

- `--rm` — elimina el contenedor al salir.
- `-it` — abre una terminal interactiva.
- `bash` — reemplaza el comando por defecto y abre directamente un shell.

### Montar un workspace de automatización

```bash
docker run --rm -it \
  -v "$PWD:/automation" \
  -w /automation \
  docker_loadbalancers_automation bash
```

Esto monta el directorio actual del host dentro de `/automation` en el contenedor.

---

## ✅ Validar el entorno

Después de construir la imagen, los componentes principales se pueden verificar con:

```bash
ansible --version
```

```bash
ansible-galaxy collection list
```

```bash
python3 -m pip show requests urllib3 f5-sdk acos-client
```

Estos comandos validan el motor Ansible, las colecciones de fabricante instaladas y las dependencias Python.

---

## 🚀 Alcance de automatización

El entorno está orientado a soportar flujos como:

- Recolección de información de dispositivos y plataformas
- Administración de Virtual Servers / VIPs
- Administración de Pools y Service Groups
- Gestión de servidores backend / pool members
- Configuración de health monitors
- Automatización relacionada con SSL/TLS
- Recolección y backup de configuraciones
- Recolección de estado operacional
- Validaciones y health checks
- Cambios masivos de configuración
- Reportes
- Flujos de pre-check y post-check

Los flujos específicos de automatización se agregarán progresivamente a medida que se desarrollen scripts, playbooks y laboratorios.

---

## ⚙️ Arquitectura de automatización

```text
Git / Automation Workspace
          │
          ▼
Docker Container
          │
          ├── Python 3
          ├── Ansible Core
          ├── Vendor SDKs
          ├── Ansible Collections
          └── HTTP / REST libraries
          │
          ▼
Load Balancers / ADCs
          │
          ├── F5 Networks BIG-IP
          ├── A10 Networks Thunder / ACOS
          └── NetScaler ADC
```

---

## 🧪 Primero en laboratorio

Toda automatización desarrollada con esta imagen debe validarse primero en laboratorios o entornos controlados antes de adaptarse a infraestructura ADC de producción.

---

## 🔒 Principios de seguridad

- No almacenar credenciales dentro de la imagen Docker.
- No subir tokens API ni contraseñas a Git.
- Preferir HTTPS para comunicación por API.
- Inyectar credenciales en tiempo de ejecución mediante variables de entorno, gestores de secretos o credenciales de la plataforma de automatización.
- Validar los cambios antes de producción.
- Utilizar cuentas con mínimos privilegios siempre que sea posible.

---

## 🔗 Proyectos relacionados

- [docker_network_automation](https://github.com/andersonmavi30/docker_network_automation)
- [docker_firewall_automation](https://github.com/andersonmavi30/docker_firewall_automation)
- [loadbalancers_automation](https://github.com/andersonmavi30/loadbalancers_automation)

---

## 🗺️ Roadmap

El entorno base Docker ya está implementado. Como trabajo futuro se contempla:

- Agregar playbooks y scripts Python de ejemplo para F5 BIG-IP
- Agregar flujos de ejemplo para A10 ACOS / aXAPI
- Agregar playbooks para NetScaler ADC y flujos NITRO
- Agregar smoke tests del entorno
- Integrar validaciones CI/CD
- Crear builds multi-arquitectura
- Publicar imágenes versionadas del contenedor
- Agregar ejemplos reutilizables de inventario
- Agregar ejemplos de automatización pre-check / post-check
- Agregar flujos de reporting y validación

---

## 📊 Estado del repositorio

> 🚧 **Contenedor base implementado / Desarrollo continuo**

Base actualmente implementada:

**Rocky Linux 10 | Python 3 | Ansible Core | F5 Networks | A10 Networks | NetScaler ADC**

---

## 📄 Licencia

MIT License — consultar `LICENSE`.

## 👨‍💻 Autor

**Anderson Martinez Virviescas**

Network Administrator | Network Automation | NetDevOps | DevNet | Linux | Infrastructure Automation | Cybersecurity

GitHub: [@andersonmavi30](https://github.com/andersonmavi30)

---

> Automate the network. Automate the firewall. Automate the application delivery infrastructure.
