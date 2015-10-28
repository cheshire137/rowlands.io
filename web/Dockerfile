FROM owncloud:8.1
MAINTAINER Jonathan Rowlands <jonrowlands83@gmail.com>

RUN apt-get update && apt-get install -y vim ansible libldap2-dev git npm \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ --with-ldap \
    && docker-php-ext-install ldap \
    && docker-php-ext-install gettext


RUN mkdir -p /usr/share/ansible_plugins/filter_plugins/split && git clone https://github.com/timraasveld/ansible-string-split-filter.git \
    /usr/share/ansible_plugins/filter_plugins/split

RUN ln -s /usr/share/ansible_plugins/filter_plugins/split/split.py /usr/share/ansible_plugins/filter_plugins/split.py

# phamm
RUN mkdir -p /usr/share && curl -SL http://open.rhx.it/phamm/phamm-0.6.4.tar.gz | tar xvz -C /usr/share && mv /usr/share/phamm-0.6.4 /usr/share/phamm
RUN chown www-data:nogroup -R /usr/share/phamm

# rainloop
RUN mkdir -p /usr/share/rainloop
WORKDIR "/usr/share/rainloop"
RUN curl -s http://repository.rainloop.net/installer.php | php
RUN chown -R www-data:nogroup /usr/share/rainloop

RUN apt-get install -y curl
RUN curl --silent --location https://deb.nodesource.com/setup_0.12 | bash -
RUN apt-get install -y nodejs

#RUN mkdir -p /usr/share/vector-web
#WORKDIR "/usr/share/vector-web"
#RUN git clone https://github.com/vector-im/vector-web.git  .
#RUN npm build
#RUN npm run build
#RUN chown -R www-data:nogroup /usr/share/vector-web

WORKDIR "/"
RUN mkdir -p /var/local/www/html

ADD jgrowl.configure_web /etc/ansible/roles/jgrowl.configure_web
ADD main.yml /etc/ansible/main.yml

#EXPOSE 80 443
#VOLUME ["/var/lib/openldap/openldap-data"]
#CMD ["/usr/local/bin/entry.sh"]

COPY entry.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
