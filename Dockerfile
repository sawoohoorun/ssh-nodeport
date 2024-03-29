FROM registry.access.redhat.com/ubi8/ubi:latest

# Update package lists and install SSH server
RUN yum update -y && yum install openssh-server -y

# Allow root login (not recommended for production)
RUN sed -i 's/PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config

# Set root password (not recommended for production) - adjust with your desired complexity
RUN echo "root:r3dh4t1!" | chpasswd

# Expose SSH port
EXPOSE 22

# Restart SSH service (optional)
CMD ["/usr/sbin/sshd", "-D"]