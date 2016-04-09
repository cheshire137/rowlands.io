FROM generik/ansible
MAINTAINER Jonathan Rowlands <jonrowlands83@gmail.com>

RUN apk --update add tinc && rm -rf /var/cache/apk/*

## For 1.1pree11
#RUN apk --update add g++ ncurses-dev wget make openssl-dev lzo-dev zlib-dev readline-dev linux-headers && rm -rf /var/cache/apk/*
#RUN cd /tmp && wget http://tinc-vpn.org/packages/tinc-1.1pre11.tar.gz && tar xzf tinc-1.1pre11.tar.gz && cd tinc-1.1pre11 && ./configure --prefix= && make && make install

ADD main.yml /etc/ansible/main.yml
ADD jgrowl.configure_tinc /etc/ansible/roles/jgrowl.configure_tinc
ADD keygen.sh /usr/local/bin/keygen.sh
ADD entrypoint.sh /usr/local/bin/entrypoint.sh

EXPOSE 655/tcp 655/udp

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
