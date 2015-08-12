# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.17
MAINTAINER Jonathan Rowlands <jonrowlands83@gmail.com>

EXPOSE 25 587 80 110 143

VOLUME ["/var/mail/"]

RUN echo mail > /etc/hostname;

RUN apt-get update

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive

RUN echo postfix postfix/main_mailer_type string Internet site | debconf-set-selections;\
  echo postfix postfix/mailname string mail.example.com | debconf-set-selections

RUN echo "mysql-server mysql-server/root_password password rootpassword" | debconf-set-selections;\
  echo "mysql-server mysql-server/root_password_again password rootpassword" | debconf-set-selections


#RUN apt-get install -y postfix mysql-server mysql-client postfix-mysql courier-pop courier-pop-ssl \
#    courier-imap courier-imap-ssl libsasl2-2 sasl2-bin libsasl2-modules


RUN apt-get install -y postfix mysql-server mysql-client postfix-mysql courier-authdaemon courier-pop courier-pop-ssl \
    courier-imap courier-imap-ssl libsasl2-2 sasl2-bin libsasl2-modules

RUN service courier-authdaemon start && apt-get install -y courier-authlib-mysql


# doesn't exist:
#postfix-tls
#libsasl2

#To install Cyrus SASL library, install the libsasl2 package.
#To add authentication mechanisms for the SASL library, install the libsasl2-modules package.
#To add MySQL support authentication mechanisms with the SASL library, install the libsasl2-modules-sql package.
RUN apt-get install -y libsasl2-2 libsasl2-modules libpam-mysql
#libsasl2-modules-sql

# sudo mysqladmin -u root -p rootpassword

#COPY etc/postfix/postfixadmin-mysql.sql /etc/postfix/postfixadmin-mysql.sql
#RUN service mysql start && sleep 5 && \
#  mysqladmin -u root -prootpassword status && \
#  mysql -u root -prootpassword < /etc/postfix/postfixadmin-mysql.sql

COPY etc/postfix/main.cf /etc/postfix/main.cf
COPY etc/postfix/mysql_relay_domains_maps.cf /etc/postfix/mysql_relay_domains_maps.cf
COPY etc/postfix/mysql_virtual_alias_maps.cf /etc/postfix/mysql_virtual_alias_maps.cf
COPY etc/postfix/mysql_virtual_domains_maps.cf /etc/postfix/mysql_virtual_domains_maps.cf
COPY etc/postfix/mysql_virtual_mailbox_limit_maps.cf /etc/postfix/mysql_virtual_mailbox_limit_maps.cf
COPY etc/postfix/mysql_virtual_mailbox_maps.cf /etc/postfix/mysql_virtual_mailbox_maps.cf

RUN chgrp postfix /etc/postfix/mysql_*.cf
RUN chmod 640 /etc/postfix/mysql_*.cf

RUN groupadd -g 5000 vmail
#RUN useradd -m -g vmail -u 5000 -d /home/vmail -s /bin/bash vmail
RUN useradd -m -g vmail -u 5000 -d /var/mail/ -s /bin/bash vmail

RUN chown -R vmail:vmail /var/mail

RUN usermod -G sasl postfix

# The baseimage-docker init system, /sbin/my_init, runs the following scripts during startup, in the following order:
# All executable scripts in /etc/my_init.d, if this directory exists. The scripts are run in lexicographic order.
# The script /etc/rc.local, if this file exists.

# Use baseimage-docker's init system.
#CMD ["/sbin/my_init"]

RUN apt-get install -y rsyslog supervisor

# ADMIN
#RUN apt-get install -y apache2 php5
#ADD http://iweb.dl.sourceforge.net/project/postfixadmin/postfixadmin/postfixadmin-2.92/postfixadmin-2.92.tar.gz /usr/local/src
RUN apt-get install -y dbconfig-common wwwconfig-common apache2 php5 php5-cli php5-imap php5-mysql
#RUN apt-get install -y apache2 php5

RUN php5enmod imap

RUN echo "postfixadmin postfixadmin/mysql/admin-pass password rootpassword" | debconf-set-selections

ADD http://iweb.dl.sourceforge.net/project/postfixadmin/postfixadmin/postfixadmin-2.92/postfixadmin_2.92-1_all.deb /tmp/postfixadmin.deb
RUN service mysql start && sleep 5 && dpkg -i /tmp/postfixadmin.deb
RUN apt-get install -f

ADD etc/apache2/conf-available/servername.conf /etc/apache2/conf-available/servername.conf
RUN a2enconf servername
RUN service apache2 restart

# dkim
RUN apt-get install -y opendkim opendkim-tools

# rainloop
RUN apt-get install -y php5-curl
WORKDIR "/var/www/html"
RUN rm /var/www/html/index.html
RUN curl -s http://repository.rainloop.net/installer.php | php
WORKDIR "/"

# spamassassin
RUN apt-get install -y spamassassin spamc
RUN groupadd spamd
RUN useradd -g spamd -s /bin/false -d /var/log/spamassassin spamd
RUN mkdir /var/log/spamassassin
RUN chown spamd:spamd /var/log/spamassassin

RUN apt-get install -y postgrey

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#postconf -e smtpd_banner="\$myhostname ESMTP" && \
RUN postconf -e mail_spool_directory="/var/mail/" && \
    postconf -e mailbox_command="" && \
    # Configure Rsyslog: Disable mail logs
    sed -i -e 's@^mail.*@@g' /etc/rsyslog.conf

ADD etc/rsyslog.d/rsyslogd.conf /etc/rsyslog.d/rsyslogd.conf
ADD etc/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
ADD entry.sh /usr/local/bin/entry.sh
ADD postfix.sh /usr/local/bin/postfix.sh
ADD apache2.sh /usr/local/bin/apache2.sh
ADD spamassassin.sh /usr/local/bin/spamassassin.sh
ADD postgrey.sh /usr/local/bin/postgrey.sh
ADD authdaemon.sh /usr/local/bin/authdaemon.sh
ADD saslauthd.sh /usr/local/bin/saslauthd.sh
ADD pop.sh /usr/local/bin/pop.sh
ADD pop-ssl.sh /usr/local/bin/pop-ssl.sh
ADD opendkim.sh /usr/local/bin/opendkim.sh
ADD imap.sh /usr/local/bin/imap.sh
ADD imap-ssl.sh /usr/local/bin/imap-ssl.sh
ADD etc/courier/authdaemonrc /etc/courier/authdaemonrc
ADD etc/courier/authmysqlrc etc/courier/authmysqlrc
ADD etc/postfix/sasl/smtpd.conf /etc/postfix/sasl/smtpd.conf
ADD etc/default/saslauthd /etc/default/saslauthd
ADD etc/pam.d/smtp /etc/pam.d/smtp
ADD etc/opendkim.conf /etc/opendkim.conf
ADD etc/default/opendkim /etc/default/opendkim

ENTRYPOINT ["/usr/local/bin/entry.sh"]
CMD ["supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
