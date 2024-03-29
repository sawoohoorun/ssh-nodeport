# Base Image
FROM registry.access.redhat.com/ubi8/ubi:latest

# Update packages and install OpenSSH server
RUN yum update -y && yum install -y openssh-server

# Create the 'redhat' user
RUN useradd --create-home --shell /bin/bash redhat

# Set the password for the 'redhat' user
RUN echo 'redhat:r3dh4t1!' | chpasswd 

# Configure SSH to allow the 'redhat' user 
# (Adjust specific settings in /etc/ssh/sshd_config as needed)
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/g' /etc/ssh/sshd_config

# Expose SSH Port 
EXPOSE 22

# Enable and start sshd service
RUN systemctl enable sshd.service && systemctl start sshd.service

# Command to keep the container running
CMD ["/bin/bash", "-c", "while true; do sleep 30; done"] 