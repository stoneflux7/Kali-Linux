FROM kalilinux/kali-rolling

LABEL maintainer="stoneflux"

ENV DEBIAN_FRONTEND=noninteractive

# Update system and install Kali full tools + SSH + networking utilities
RUN apt update && \
    apt full-upgrade -y && \
    apt install -y kali-linux-everything openssh-server net-tools iputils-ping curl wget git sudo && \
    apt clean

# Set root password to stoneflux
RUN echo "root:stoneflux" | chpasswd

# Set custom shell prompt to root@stoneflux
RUN echo 'export PS1="root@stoneflux:\\w# "' >> /root/.bashrc

# SSH setup
RUN mkdir /var/run/sshd

# Expose SSH port
EXPOSE 22

# Start SSH by default
CMD ["/usr/sbin/sshd", "-D"]
