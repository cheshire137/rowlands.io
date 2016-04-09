FROM generik/ansible:v2.0
MAINTAINER Jonathan Rowlands <jonrowlands83@gmail.com>

RUN apk --update --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted add curl ca-certificates docker python3 && \
    curl -Ls https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk > /tmp/glibc-2.21-r2.apk && \
    apk add --allow-untrusted /tmp/glibc-2.21-r2.apk && \
    rm -rf /tmp/glibc-2.21-r2.apk /var/cache/apk/*


#    RUN apk --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted add docker \
#    && rm -rf /var/cache/apk/*

#RUN curl -L https://github.com/docker/machine/releases/download/v0.5.0/docker-machine_linux-amd64.zip > machine.zip && \
#    unzip machine.zip && \
#    rm machine.zip && \
#    mv docker-machine* /usr/local/bin

RUN curl -L https://github.com/docker/machine/releases/download/v0.5.3/docker-machine_linux-amd64 > /usr/local/bin/docker-machine && \
    chmod +x /usr/local/bin/docker-machine

RUN pip install docker-py

ADD lib/docker-machine-py/docker_machine /opt/ansible/ansible/lib/docker_machine

RUN mkdir -p /opt/ansible/ansible/library
ADD lib/ansible-docker-machine/library/docker_machine /opt/ansible/ansible/library/docker_machine
# TODO add entire dir

RUN mkdir -p /usr/share/ansible/plugins/connection_plugins
ADD lib/ansible-docker-machine/connection_plugins/docker_machine.py /usr/share/ansible/plugins/connection/docker_machine.py
ADD lib/docker-sync /usr/local/bin/docker-sync

#RUN mkdir -p ~/.ssh
#RUN touch ~/.ssh/known_hosts

# This is some temporary ugliness until --devices gets added to docker command in 2.1
RUN cd /opt/ansible/ansible && git checkout devel
RUN cd /opt/ansible/ansible && git pull
RUN cd /opt/ansible/ansible/lib/ansible/modules/core &&  git checkout devel
RUN cd /opt/ansible/ansible/lib/ansible/modules/core && git pull
#RUN cd /opt/ansible/ansible/lib/ansible/modules/core && wget https://github.com/kaczynskid/ansible-modules-core/commit/46970d6d7add50780e8cedb5067ae5d29a763141.patch -O docker-fix.patch
#RUN cd /opt/ansible/ansible/lib/ansible/modules/core && git apply docker-fix.patch

ADD images/tinc/jgrowl.configure_tinc /etc/ansible/roles/jgrowl.configure_tinc
ADD images/flocker/jgrowl.flocker /etc/ansible/roles/jgrowl.flocker

ADD ./playbooks /etc/ansible/playbooks
ADD entrypoint.sh /usr/local/bin/entrypoint.sh
ADD images/tinc /etc/ansible/tinc

ENV PATH /usr/local/bin:$PATH

RUN rm /etc/ansible/hosts

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
