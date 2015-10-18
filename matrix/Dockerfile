FROM generik/ansible
MAINTAINER Jonathan Rowlands <jonrowlands83@gmail.com>

RUN apk --update add build-base py-virtualenv openssl-dev libffi-dev sqlite python-dev gcc musl-dev py-pillow \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /opt/synapse
RUN virtualenv -p python2.7 /opt/synapse
RUN source /opt/synapse/bin/activate
RUN pip install --upgrade setuptools
RUN pip install --process-dependency-links https://github.com/matrix-org/synapse/tarball/master

RUN mkdir -p /etc/synapse

ADD jgrowl.configure_synapse /etc/ansible/roles/jgrowl.configure_synapse
ADD main.yml /etc/ansible/main.yml
ADD entry.sh /usr/local/bin/entry.sh

EXPOSE 8448
RUN mkdir -p /var/synapse
WORKDIR /var/synapse
VOLUME ["/var/synapse"]
CMD ["/usr/local/bin/entry.sh"]
