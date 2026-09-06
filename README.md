# 🚀 docker_loadbalancers_automation

🇨🇴 [Español](README.es.md)

All-in-one Docker environment designed for **multi-vendor Load Balancer / Application Delivery Controller automation**.

**F5 Networks BIG-IP · A10 Networks Thunder / ACOS · Citrix NetScaler ADC**

Built with the same philosophy as:

- [docker_network_automation](https://github.com/andersonmavi30/docker_network_automation) — Network Automation
- [docker_firewall_automation](https://github.com/andersonmavi30/docker_firewall_automation) — Firewall Automation

This repository extends that automation ecosystem to **Application Delivery Controllers and Load Balancers**.

---

## 🎯 Project Objective

The goal of this project is to build a portable Docker image containing the tools required to automate common Load Balancer and ADC administration tasks.

Instead of installing Python libraries, Ansible collections and API tools directly on the automation host, the required environment can be packaged inside a reusable container.

The project is designed around:

- Multi-vendor automation
- API-first workflows
- Python automation
- Ansible automation
- Reproducible environments
- Infrastructure as Code
- NetDevOps practices
- CI/CD integration

## ⚖️ Supported Platforms

| Vendor | Platform | Automation Interface |
|---|---|---|
| **F5 Networks** | BIG-IP / LTM | iControl REST API / Ansible |
| **A10 Networks** | Thunder ADC / ACOS | aXAPI v3 REST API |
| **Citrix / NetScaler** | NetScaler ADC | NITRO REST API |

### F5 Networks BIG-IP

Automation can progressively use:

- iControl REST API
- `f5networks.f5_modules`
- Python
- HTTP/REST automation
- Ansible

Typical objects may include:

- Virtual Servers
- Pools
- Pool Members
- Nodes
- Health Monitors
- Profiles
- SSL/TLS objects
- High Availability
- Configuration backups
- Operational information

### A10 Networks Thunder ADC

Automation will primarily use **aXAPI**, the REST-based automation interface available on A10 ACOS.

Planned automation areas include:

- Virtual Servers
- Service Groups
- Real Servers
- Health Monitors
- SSL templates
- Traffic management
- Configuration management
- Operational statistics
- Backup and validation

### Citrix NetScaler ADC

Automation will progressively use the **NITRO REST API** and available automation tooling.

Planned areas include:

- Load Balancing Virtual Servers
- Services
- Service Groups
- Servers
- Health Monitors
- SSL configuration
- Content Switching
- Configuration backups
- Operational information

## 🧰 Container Contents — Planned

### 🐍 Python

- Python 3
- `requests`
- `httpx`
- `urllib3`
- `pyyaml`
- `jinja2`
- `netmiko`
- `paramiko`

Additional vendor-specific SDKs may be incorporated when required.

### 🤖 Ansible

Ansible will be included for vendor automation where appropriate.

F5 BIG-IP automation can use:

```text
f5networks.f5_modules
```

Other vendors may be automated through their REST APIs, SDKs or supported Ansible integrations.

### 🛠️ Linux / API Utilities

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

## 🚀 Planned Automation Areas

- Device inventory collection
- Health checks
- Virtual server creation
- Pool / service group creation
- Backend server management
- Health monitor configuration
- SSL/TLS configuration
- Configuration backups
- Configuration validation
- Pre-checks
- Post-checks
- Operational state collection
- Statistics collection
- Configuration deployment
- Bulk changes
- Reporting
- Automated remediation
- CI/CD integration

## ⚙️ Automation Architecture

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
Validation / Reporting
```

## 🗂️ Planned Repository Structure

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

## ⚡ Usage — Planned

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

## 🔄 NetDevOps Workflow

```text
Git
 │
 ▼
Change
 │
 ▼
Validation
 │
 ▼
Containerized Automation
 │
 ▼
ADC / Load Balancer
 │
 ▼
Post-check
 │
 ▼
Report
```

## 🧪 Lab First

Automation developed with this image should first be validated against laboratory or controlled environments before being used with production ADC infrastructure.

## 🔒 Security Principles

- Avoid storing credentials in the image
- Use environment variables or secret management
- Prefer HTTPS APIs
- Keep dependencies version controlled
- Run automation with least privilege where possible
- Separate automation code from credentials
- Validate changes before production deployment

## 🔗 Related Projects

- [docker_network_automation](https://github.com/andersonmavi30/docker_network_automation)
- [docker_firewall_automation](https://github.com/andersonmavi30/docker_firewall_automation)
- [loadbalancers_automation](https://github.com/andersonmavi30/loadbalancers_automation)

## 🗺️ Roadmap

- Build the initial Docker image
- Add Python automation dependencies
- Add F5 BIG-IP automation tooling
- Add A10 aXAPI tooling
- Add NetScaler NITRO API tooling
- Add container smoke tests
- Add multi-architecture builds
- Add CI/CD
- Publish versioned Docker images
- Add example automation workflows

## 📊 Repository Status

> 🚧 **Initial Development / Work in Progress**

Current target platforms:

**F5 Networks BIG-IP | A10 Networks Thunder ADC | Citrix NetScaler ADC**

## 📄 License

MIT License — see `LICENSE`.

## 👨‍💻 Author

**Anderson Martinez Virviescas**

Network Administrator | Network Automation | NetDevOps | DevNet | Linux | Infrastructure Automation | Cybersecurity

GitHub: [@andersonmavi30](https://github.com/andersonmavi30)

---

> Automate the network. Automate the firewall. Automate the application delivery infrastructure.
