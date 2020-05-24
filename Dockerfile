FROM debian:stable-slim

# Time
ENV TZ 'Europe/Berlin'

# Froxlor
ENV FRX_MAIL_DIR '/var/customers/mail'
ENV FRX_DB_HOST 'localhost'
ENV FRX_DB_NAME 'froxlor'
ENV FRX_DB_USER 'froxlor'
ENV FRX_DB_PASSWORD ''

# Postfix
ENV MAIL_DOMAIN 'example.com'

# Dovecot
ENV POSTMASTER_ADDRESS 'postmaster@example.com'

# Log
ENV LOG_DIR '/var/log/mail'

# Mail
ENV ROOT_ALIAS 'root@example.com'

# Cleanup scripts
ENV CLEANUP_TRASH 30
ENV CLEANUP_SPAM 60

# Postfix
EXPOSE 25
EXPOSE 465
# Dovecot
EXPOSE 110
EXPOSE 143
EXPOSE 993
EXPOSE 995
# Dovecot Sieve
EXPOSE 4190

# Pre-seeding for Postfix installation
RUN echo "postfix postfix/mailname string mail.example.com" | debconf-set-selections && \
	echo "postfix postfix/main_mailer_type string 'No configuration'" | debconf-set-selections

# Update sources and preinstalled packages
RUN apt-get update && \
    apt-get upgrade -y --no-install-recommends

# Install dependencies
RUN apt-get install -y --no-install-recommends \
	apt-utils \
	cron \
	gettext-base \
    logrotate \
    ca-certificates \
    unattended-upgrades \
    apt-listchanges \
    syslog-ng

# Install Postfix
RUN apt-get install -y --no-install-recommends \
    postfix \
    postfix-mysql

# Configure Postfix
COPY ./etc/postfix /etc/postfix/
COPY ./etc/aliases /etc/aliases

# Install Dovecot
RUN apt-get install -y --no-install-recommends \
    dovecot-mysql \
    dovecot-imapd \
    dovecot-pop3d \
    dovecot-sieve \
    dovecot-managesieved

# Configure Dovecot
COPY ./etc/dovecot /etc/dovecot/

# Create mail user and group
RUN groupadd -g 2000 vmail && \
    useradd -u 2000 -g vmail vmail

# Create folders
RUN mkdir -p ${FRX_MAIL_DIR}/.sieve/.before && \
	mkdir -p ${LOG_DIR} && \
    mkdir -p /var/spool/postfix/etc/pam.d && \
	mkdir -p /var/spool/postfix/var/run/mysqld

# Configure Sieve
COPY .${FRX_MAIL_DIR}/.sieve/.before ${FRX_MAIL_DIR}/.sieve/.before/

# Set rights
RUN chown -R 2000:2000 ${FRX_MAIL_DIR} && \
	chmod -R 0750 ${FRX_MAIL_DIR} && \
    chown -R root:adm ${LOG_DIR} && \
    chmod -R 0770 ${LOG_DIR}

# Install SpamAssassin client
RUN apt-get install -y --no-install-recommends \
    spamc

# Create SpamAssassin user and group
RUN groupadd debian-spamd && \
    useradd -g debian-spamd debian-spamd

# Add Logrotate scripts
COPY ./etc/logrotate.d /etc/logrotate.d/

# Add Spam and Trash cleanup scripts
COPY ./etc/cron.d /etc/cron.d/

COPY ./start.sh /start.sh

ENTRYPOINT ["bash", "/start.sh"]
