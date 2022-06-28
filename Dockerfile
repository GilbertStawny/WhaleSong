#base image
FROM amazonlinux:latest
MAINTAINER "GilbertStawny" <gilbert.stawny@lacework.net>

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && yum update -y && yum upgrade -y
RUN yum install -y tcpdump traceroute telnet nmap bind-utils iperf3 net-tools dhcping ethtool mtr openssl iftop wget openssh-server iproute nmap

#Installs ctop
RUN wget https://github.com/bcicen/ctop/releases/download/v0.7.1/ctop-0.7.1-linux-amd64 -O /usr/local/bin/ctop && chmod +x /usr/local/bin/ctop

#personalization of bash shell
ADD motd /root/motd
ADD profile  /etc/profile
ADD entrypoint.sh /root/entrypoint.sh
# Configure SSH daemon
ADD sshd_config /etc/ssh/sshd_config
ADD ssh_host_rsa_key /etc/ssh/ssh_host_rsa_key
ADD ssh_host_ecdsa_key /etc/ssh/ssh_host_ecdsa_key
ADD ssh_host_ed25519_key /etc/ssh/ssh_host_ed25519_key
RUN chmod 400 /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_ecdsa_key /etc/ssh/ssh_host_ed25519_key && echo 'root:S3cR3tPAssw0rD' | chpasswd

EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
