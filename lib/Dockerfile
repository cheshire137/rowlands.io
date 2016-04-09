FROM generik/ansible:v2.0
MAINTAINER Jonathan Rowlands <jonrowlands83@gmail.com>

RUN apk --update --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted add curl ca-certificates docker && \
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

RUN mkdir -p /opt/ansible/ansible/library
ADD ansible-docker-machine/library/docker_machine /opt/ansible/ansible/library/docker_machine
# TODO add entire dir

RUN mkdir -p /usr/share/ansible/plugins/connection_plugins
ADD ansible-docker-machine/connection_plugins/docker_machine.py /usr/share/ansible/plugins/connection/docker_machine.py

#ENV PATH /usr/local/bin:$PATH
#
#CMD ["/usr/local/bin/entry.sh"]
