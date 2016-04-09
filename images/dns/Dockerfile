FROM jgrowl/ansible
MAINTAINER Jonathan Rowlands

RUN apk --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted add \
        pdns pdns-backend-ldap  \
    && rm -rf /var/cache/apk/*

RUN ln -s /usr/lib/pdns/pdns/libldapbackend.so /usr/lib/pdns/libldapbackend.so

ADD jgrowl.configure_dns /etc/ansible/roles/jgrowl.configure_dns
ADD main.yml /etc/ansible/main.yml
ADD entry.sh /usr/local/bin/entry.sh

ENV PATH /opt/ansible/ansible/bin:/bin:/usr/bin:/sbin:/usr/sbin

EXPOSE 53/udp 53/tcp

CMD ["/usr/local/bin/entry.sh"]
