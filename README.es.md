# 🚀 docker_loadbalancers_automation

🇺🇸 [English](README.md)

Entorno Docker todo en uno diseñado para la **automatización multi-vendor de Load Balancers y Application Delivery Controllers (ADC)**.

**F5 Networks BIG-IP · A10 Networks Thunder / ACOS · Citrix NetScaler ADC**

Construido siguiendo la misma filosofía de:

- [docker_network_automation](https://github.com/andersonmavi30/docker_network_automation) — Network Automation
- [docker_firewall_automation](https://github.com/andersonmavi30/docker_firewall_automation) — Firewall Automation

Este repositorio extiende ese ecosistema hacia la **automatización de Load Balancers y Application Delivery Controllers**.

---

## 🎯 Objetivo del proyecto

El objetivo es construir una imagen Docker portable que contenga las herramientas necesarias para automatizar tareas comunes de administración de Load Balancers y ADC.

En lugar de instalar librerías Python, colecciones de Ansible y herramientas para APIs directamente en el servidor de automatización, el entorno completo podrá empaquetarse dentro de un contenedor reutilizable.

El proyecto está orientado a:

- Automatización multi-vendor
- Automatización basada en APIs
- Python
- Ansible
- Entornos reproducibles
- Infrastructure as Code
- NetDevOps
- Integración CI/CD

## ⚖️ Plataformas

| Fabricante | Plataforma | Interfaz de automatización |
|---|---|---|
| **F5 Networks** | BIG-IP / LTM | iControl REST API / Ansible |
| **A10 Networks** | Thunder ADC / ACOS | aXAPI v3 REST API |
| **Citrix / NetScaler** | NetScaler ADC | NITRO REST API |

## 🧰 Contenido del contenedor — Previsto

### 🐍 Python

- Python 3
- `requests`
- `httpx`
- `urllib3`
- `pyyaml`
- `jinja2`
- `netmiko`
- `paramiko`

### 🤖 Ansible

Para F5 BIG-IP se contempla:

```text
f5networks.f5_modules
```

A10 y NetScaler podrán administrarse mediante sus APIs, SDKs o integraciones disponibles.

### 🛠️ Utilidades Linux / API

```text
curl
wget
git
jq
ssh
ping
openssl
vim
yq
```

## 🚀 Áreas de automatización previstas

- Inventario de dispositivos
- Health checks
- Creación de Virtual Servers
- Creación de Pools / Service Groups
- Administración de servidores backend
- Health Monitors
- SSL/TLS
- Backups
- Validación de configuración
- Pre-checks
- Post-checks
- Estado operacional
- Estadísticas
- Despliegue de configuración
- Cambios masivos
- Reportes
- Remediación automatizada
- Integración CI/CD

## ⚙️ Arquitectura

```text
Git
 │
 ▼
Docker Image
 │
 ├── Python
 │
 ├── Ansible
 │
 ├── REST APIs
 │
 └── Automation Tools
 │
 ▼
Load Balancers / ADCs
 │
 ├── F5 BIG-IP
 ├── A10 Thunder
 └── NetScaler ADC
 │
 ▼
Validación / Reportes
```

## 🗂️ Estructura prevista

```text
docker_loadbalancers_automation/
│
├── Dockerfile
├── requirements.txt
├── collections.yml
├── .dockerignore
├── .github/
│   └── workflows/
├── README.md
├── README.es.md
└── LICENSE
```

## ⚡ Uso — Previsto

```bash
docker build -t docker_loadbalancers_automation .
```

```bash
docker run --rm -it docker_loadbalancers_automation bash
```

```bash
docker run --rm -it \
  -v "$PWD:/workspace" \
  -w /workspace \
  docker_loadbalancers_automation bash
```

## 🔄 Flujo NetDevOps

```text
Git
 │
 ▼
Cambio
 │
 ▼
Validación
 │
 ▼
Automatización en Docker
 │
 ▼
ADC / Load Balancer
 │
 ▼
Post-check
 │
 ▼
Reporte
```

## 🧪 Primero en laboratorio

Toda automatización debe validarse primero en laboratorios o entornos controlados antes de adaptarse a infraestructura productiva.

## 🔒 Principios de seguridad

- No almacenar credenciales dentro de la imagen
- Utilizar variables de entorno o gestores de secretos
- Preferir APIs HTTPS
- Mantener dependencias versionadas
- Utilizar mínimos privilegios
- Separar código y credenciales
- Validar cambios antes de producción

## 🔗 Proyectos relacionados

- [docker_network_automation](https://github.com/andersonmavi30/docker_network_automation)
- [docker_firewall_automation](https://github.com/andersonmavi30/docker_firewall_automation)
- [loadbalancers_automation](https://github.com/andersonmavi30/loadbalancers_automation)

## 🗺️ Roadmap

- Construir la primera imagen Docker
- Incorporar dependencias Python
- Agregar herramientas para F5 BIG-IP
- Agregar automatización con A10 aXAPI
- Agregar automatización con NetScaler NITRO API
- Crear smoke tests
- Crear imágenes multi-arquitectura
- Integrar CI/CD
- Publicar imágenes Docker versionadas
- Agregar ejemplos de automatización

## 📊 Estado

> 🚧 **Desarrollo inicial / Work in Progress**

Plataformas objetivo:

**F5 Networks BIG-IP | A10 Networks Thunder ADC | Citrix NetScaler ADC**

## 📄 Licencia

MIT — consultar `LICENSE`.

## 👨‍💻 Autor

**Anderson Martinez Virviescas**

Network Administrator | Network Automation | NetDevOps | DevNet | Linux | Infrastructure Automation | Cybersecurity

GitHub: [@andersonmavi30](https://github.com/andersonmavi30)

---

> Automate the network. Automate the firewall. Automate the application delivery infrastructure.
