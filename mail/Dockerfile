# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.17
MAINTAINER Jonathan Rowlands <jonrowlands83@gmail.com>

EXPOSE 25 110 143 465 587 993

VOLUME ["/var/mail/"]

RUN echo mail > /etc/hostname;

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get install -y ansible postfix postfix-ldap courier-authdaemon courier-authlib-ldap \
    courier-pop courier-pop-ssl courier-imap courier-imap-ssl libsasl2-2 sasl2-bin libsasl2-modules libsasl2-2 \
    libsasl2-modules supervisor opendkim opendkim-tools spamassassin spamc postgrey \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo postfix postfix/main_mailer_type string Internet site | debconf-set-selections;\
  echo postfix postfix/mailname string mail.example.com | debconf-set-selections

RUN usermod -G sasl postfix

ADD etc/ansible/roles/jgrowl.configure_mail /etc/ansible/roles/jgrowl.configure_mail

# spamassassin
RUN groupadd spamd
RUN useradd -g spamd -s /bin/false -d /var/log/spamassassin spamd
RUN mkdir /var/log/spamassassin
RUN chown spamd:spamd /var/log/spamassassin

# Remove the certs so they can be generated
#RUN rm -f /etc/courier/pop3d.pem
#RUN rm -f /etc/courier/imapd.pem

ADD run-service.sh /usr/local/bin/run-service.sh
ADD etc/ansible/main.yml /etc/ansible/main.yml

ADD configure_with_ansible.sh /etc/my_init.d/01_configure_with_ansible.sh
ADD run_supervisor.sh /etc/my_init.d/02_run_supervisor.sh

CMD ["/sbin/my_init"]
