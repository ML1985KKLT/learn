FROM centos:6
MAINTAINER Malei
RUN yum install passwd openssl openssh-server -y
RUN echo '123123' | passwd --stdin root
EXPOSE 22
CMD /usr/sbin/sshd -D
