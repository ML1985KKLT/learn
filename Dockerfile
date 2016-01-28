FROM centos:6
MAINTAINER Malei
RUN yum install passwd openssl openssh-server -y
ADD http://prdownloads.sourceforge.net/webadmin/webmin-1.740-1.noarch.rpm /root/
RUN yum localinstall /root/webmin-1.710-1.noarch.rpm
RUN echo '123123' | passwd --stdin root
RUN ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -q -t dsa -f /etc/ssh/ssh_host_dsa_key -N ''
RUN ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
RUN sed -i '/^session\s\+required\s\+pam_loginuid.so/s/^/#/' /etc/pam.d/sshd
RUN mkdir -p /root/.ssh && chown root.root /root && chmod 700 /root/.ssh
EXPOSE 22 10000
CMD /usr/sbin/sshd -D;/usr/bin/perl /usr/libexec/webmin/miniserv.pl /etc/webmin/miniserv.conf
