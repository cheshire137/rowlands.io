FROM alpine:latest
MAINTAINER Jonathan Rowlands

RUN apk --update add py-yaml py-jinja2  py-paramiko py-setuptools git py-pip perl py-simplejson openldap-clients \
    && rm -rf /var/cache/apk/*

RUN mkdir /etc/ansible/
RUN echo '[local]\nlocalhost\n' > /etc/ansible/hosts
RUN mkdir /opt/ansible/ -p
RUN git clone http://github.com/ansible/ansible.git /opt/ansible/ansible
WORKDIR /opt/ansible/ansible
RUN git checkout v1.9.4-1
RUN git submodule update --init
ENV PATH /opt/ansible/ansible/bin:/bin:/usr/bin:/sbin:/usr/sbin
ENV PYTHONPATH /opt/ansible/ansible/lib
ENV ANSIBLE_LIBRARY /opt/ansible/ansible/library
RUN mkdir /ansible
WORKDIR /ansible
ENV PATH /opt/ansible/ansible/bin:/bin:/usr/bin:/sbin:/usr/sbin
