# Base: Rocky Linux 10
FROM rockylinux:10

# Working directory inside the container
WORKDIR /automation

# Copy dependency files
COPY requirements.txt collections.yml ./

# Install Python, pip and network tools (SSH) from the system
RUN dnf install -y epel-release && \
    dnf install -y python3 python3-pip git openssh-clients sshpass && \
    dnf clean all

# Install Python libraries
RUN pip3 install --no-cache-dir -r requirements.txt

# Install Ansible collections (F5, A10, NetScaler)
RUN ansible-galaxy collection install -r collections.yml

# Keep the container running so we can work inside it
CMD ["sleep", "infinity"]
