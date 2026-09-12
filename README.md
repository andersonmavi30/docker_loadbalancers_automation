# 🚀 docker_loadbalancers_automation

🇨🇴 [Español](README.es.md)

Containerized automation environment for **multi-vendor Load Balancers and Application Delivery Controllers (ADC)**.

**F5 Networks BIG-IP · A10 Networks Thunder / ACOS · NetScaler ADC**

This project follows the same containerized automation approach used in:

- [docker_network_automation](https://github.com/andersonmavi30/docker_network_automation) — Network Automation
- [docker_firewall_automation](https://github.com/andersonmavi30/docker_firewall_automation) — Firewall Automation

The goal is to provide a reproducible Docker-based environment with Python, Ansible and vendor-specific automation tooling for ADC and load-balancer administration.

---

## 🎯 Project Objective

This repository packages the automation dependencies required to work with multiple Load Balancer / ADC platforms into a single Docker image.

The current implementation provides:

- Rocky Linux 10 as the container base
- Python 3 and pip
- Ansible Core
- Vendor-specific Python SDKs where available
- Vendor-specific Ansible collections
- Generic HTTP/REST libraries
- SSH client utilities
- A persistent container mode for use as an automation workspace or jumpbox

This keeps automation tooling isolated from the host operating system and makes the environment easier to reproduce across labs and development systems.

---

## ⚖️ Supported Platforms

| Vendor | Platform | Current Automation Tooling |
|---|---|---|
| **F5 Networks** | BIG-IP / LTM | `f5-sdk`, `f5networks.f5_modules`, REST APIs |
| **A10 Networks** | Thunder ADC / ACOS | `acos-client`, `a10.acos_axapi`, aXAPI |
| **NetScaler** | NetScaler ADC | `netscaler.adc`, REST/NITRO workflows |

---

## 🧱 Container Base

The image currently uses:

```text
Rocky Linux 10
```

The working directory inside the container is:

```text
/automation
```

The Dockerfile installs the following system packages:

```text
python3
python3-pip
git
openssh-clients
sshpass
```

The default container command is:

```text
sleep infinity
```

This allows the container to stay running and be used as a persistent automation environment.

---

## 🐍 Python Automation Stack

The current `requirements.txt` installs:

| Package | Purpose |
|---|---|
| `ansible-core` | Core Ansible automation engine |
| `requests` | Generic HTTP/REST API requests |
| `urllib3` | HTTP/TLS connection handling |
| `f5-sdk` | Python SDK for F5 BIG-IP automation |
| `acos-client>=2.9.0` | Python client for A10 ACOS / aXAPI |

These dependencies provide both generic API access and vendor-specific automation capabilities.

---

## 🤖 Ansible Collections

The current `collections.yml` installs three vendor collections:

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

Designed for automating BIG-IP objects and operational tasks through Ansible.

### A10 Networks Thunder / ACOS

```text
a10.acos_axapi
```

Provides Ansible automation for A10 ACOS platforms using aXAPI-based workflows.

### NetScaler ADC

```text
netscaler.adc
```

Provides Ansible modules for NetScaler ADC configuration and administration.

---

## 🗂️ Current Repository Structure

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

Builds the Rocky Linux 10 automation environment, installs Python and system dependencies, installs the Python packages from `requirements.txt`, and then installs the Ansible collections from `collections.yml`.

### `requirements.txt`

Defines the Python and automation dependencies used inside the image.

### `collections.yml`

Defines the F5 Networks, A10 Networks and NetScaler Ansible collections installed during the Docker build.

---

## ⚡ Build the Image

From the repository root:

```bash
docker build -t docker_loadbalancers_automation .
```

What the command does:

- `docker build` — builds a Docker image from the Dockerfile.
- `-t docker_loadbalancers_automation` — assigns a local image name/tag.
- `.` — uses the current directory as the Docker build context.

---

## 🚀 Run the Container

### Persistent automation container

```bash
docker run -d \
  --name lb-automation \
  docker_loadbalancers_automation
```

Then enter the container:

```bash
docker exec -it lb-automation bash
```

Because the Dockerfile uses `sleep infinity`, the container remains available for automation work until it is stopped.

### Temporary interactive container

```bash
docker run --rm -it docker_loadbalancers_automation bash
```

- `--rm` — removes the container after exit.
- `-it` — opens an interactive terminal.
- `bash` — overrides the default command and opens a shell directly.

### Mount an automation workspace

```bash
docker run --rm -it \
  -v "$PWD:/automation" \
  -w /automation \
  docker_loadbalancers_automation bash
```

This mounts the current host directory into `/automation` inside the container.

---

## ✅ Validate the Environment

After building the image, the main components can be checked with:

```bash
ansible --version
```

```bash
ansible-galaxy collection list
```

```bash
python3 -m pip show requests urllib3 f5-sdk acos-client
```

These commands verify the Ansible engine, installed vendor collections and Python dependencies.

---

## 🚀 Automation Scope

The environment is intended to support workflows such as:

- Device and platform information collection
- Virtual Server / VIP administration
- Pool and Service Group administration
- Backend server / pool member management
- Health monitor configuration
- SSL/TLS-related automation
- Configuration collection and backup workflows
- Operational state collection
- Validation and health checks
- Bulk configuration changes
- Reporting
- Pre-check and post-check workflows

Specific automation workflows will be added progressively as scripts, playbooks and labs are developed.

---

## ⚙️ Automation Architecture

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

## 🧪 Lab First

Automation developed with this image should first be validated in laboratory or controlled environments before being adapted to production ADC infrastructure.

---

## 🔒 Security Principles

- Do not store credentials in the Docker image.
- Do not commit API tokens or passwords to Git.
- Prefer HTTPS for API communication.
- Inject credentials at runtime through environment variables, secret stores or automation-platform credentials.
- Validate changes before production deployment.
- Use least-privilege accounts whenever possible.

---

## 🔗 Related Projects

- [docker_network_automation](https://github.com/andersonmavi30/docker_network_automation)
- [docker_firewall_automation](https://github.com/andersonmavi30/docker_firewall_automation)
- [loadbalancers_automation](https://github.com/andersonmavi30/loadbalancers_automation)

---

## 🗺️ Roadmap

The base Docker environment is already implemented. Future work may include:

- Add example F5 BIG-IP playbooks and Python scripts
- Add example A10 ACOS / aXAPI workflows
- Add example NetScaler ADC playbooks and NITRO workflows
- Add environment smoke tests
- Add CI/CD validation
- Add multi-architecture image builds
- Publish versioned container images
- Add reusable inventory examples
- Add pre-check / post-check automation examples
- Add reporting and validation workflows

---

## 📊 Repository Status

> 🚧 **Base Container Implemented / Continuous Development**

Current implemented foundation:

**Rocky Linux 10 | Python 3 | Ansible Core | F5 Networks | A10 Networks | NetScaler ADC**

---

## 📄 License

MIT License — see `LICENSE`.

## 👨‍💻 Author

**Anderson Martinez Virviescas**

Network Administrator | Network Automation | NetDevOps | DevNet | Linux | Infrastructure Automation | Cybersecurity

GitHub: [@andersonmavi30](https://github.com/andersonmavi30)

---

> Automate the network. Automate the firewall. Automate the application delivery infrastructure.
