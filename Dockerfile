FROM debian:stable-slim

# Directories
ENV FRX_MAIL_DIR=/var/customers/mail
ENV POSTFIX_DIR=/etc/postfix
ENV DOVECOT_DIR=/etc/dovecot
ENV SRV_DIR=/srv

# Time
ENV TZ=Europe/Berlin

# Mail
ENV ROOT_ALIAS=root@example.com

# Froxlor
ENV FRX_DB_HOST=localhost
ENV FRX_DB_NAME=froxlor
ENV FRX_DB_USER=froxlor
ENV FRX_DB_PASSWORD=""

# Postfix
ENV MAIL_DOMAIN=example.com
# Dovecot
ENV POSTMASTER_ADDRESS=postmaster@example.com

# Cleanup scripts
ENV CLEANUP_TRASH=30
ENV CLEANUP_SPAM=60

# Postfix
EXPOSE 25
EXPOSE 465
# Dovecot
EXPOSE 110
EXPOSE 143
EXPOSE 993
EXPOSE 995
EXPOSE 4190

# Pre-seeding for Postfix installation
RUN echo "postfix postfix/mailname string mail.example.com" | debconf-set-selections && \
	echo "postfix postfix/main_mailer_type string 'No configuration'" | debconf-set-selections

# Update and upgrade packages
RUN apt-get update && apt-get upgrade -y --no-install-recommends

# Install packages
RUN apt-get install -y --no-install-recommends \
	apt-utils \
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
COPY .${POSTFIX_DIR} ${POSTFIX_DIR}/
COPY ./etc/aliases /etc/aliases

# Install Dovecot
RUN apt-get install -y --no-install-recommends \
    dovecot-mysql \
    dovecot-imapd \
    dovecot-pop3d \
    dovecot-sieve \
    dovecot-managesieved

# Configure Dovecot
COPY .${DOVECOT_DIR} ${DOVECOT_DIR}/

# Create mail user and group
RUN groupadd -g 2000 vmail && useradd -u 2000 -g vmail vmail

# Create folders
RUN mkdir -p ${FRX_MAIL_DIR}/.sieve/.before && \
    mkdir -p /var/log/dovecot && \
    mkdir -p /var/log/postfix && \
    mkdir -p /var/spool/postfix/etc/pam.d && \
	mkdir -p /var/spool/postfix/var/run/mysqld

# Configure Sieve
COPY .${FRX_MAIL_DIR}/.sieve/.before ${FRX_MAIL_DIR}/.sieve/.before/

# Set rights
RUN chown -R 2000:2000 ${FRX_MAIL_DIR} && \
	chmod -R 0750 ${FRX_MAIL_DIR}

# Add cleanup scripts for Trash and Spam folders
COPY ./srv /srv/

# Make cleanup scripts executeable
RUN chmod +x /srv/cleanup-*.sh

COPY ./start.sh /start.sh

ENTRYPOINT ["bash", "/start.sh"]
