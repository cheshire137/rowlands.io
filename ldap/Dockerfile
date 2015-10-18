FROM generik/ansible
MAINTAINER Jonathan Rowlands <jonrowlands83@gmail.com>

RUN apk --update add make openldap-back-bdb openldap-back-hdb openldap openldap-clients && rm -rf /var/cache/apk/*

RUN mkdir -p /usr/share/ansible_plugins/filter_plugins/split && git clone https://github.com/timraasveld/ansible-string-split-filter.git \
    /usr/share/ansible_plugins/filter_plugins/split

RUN ln -s /usr/share/ansible_plugins/filter_plugins/split/split.py /usr/share/ansible_plugins/filter_plugins/split.py

RUN mkdir -p /usr/share && curl -SL http://downloads.sourceforge.net/project/ldapscripts/ldapscripts/ldapscripts-2.0.6/ldapscripts-2.0.6.tgz \
    | tar xvz -C /usr/share && mv /usr/share/ldapscripts-2.0.6 /usr/share/ldapscripts && cd /usr/share/ldapscripts && make install
ENV PATH $PATH:/usr/local/sbin

ADD jgrowl.configure_ldap /etc/ansible/roles/jgrowl.configure_ldap
ADD main.yml /etc/ansible/main.yml
ADD entry.sh /usr/local/bin/entry.sh

EXPOSE 389 636
VOLUME ["/var/lib/openldap/openldap-data"]
CMD ["/usr/local/bin/entry.sh"]

