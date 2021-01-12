FROM debian:stable-slim

# ===================================================
# Configuration
# ===================================================

# System
ENV TZ 'Europe/Berlin'

# Froxlor
ENV FRX_MAIL_DIR '/var/customers/mail'
ENV FRX_DB_HOST 'localhost'
ENV FRX_DB_NAME 'froxlor'
ENV FRX_DB_USER 'froxlor'
ENV FRX_DB_PASSWORD ''

# Postfix/Dovecot
ENV MAIL_DOMAIN 'example.com'
ENV MESSAGE_SIZE_LIMIT 52428800
ENV MY_NETWORKS '127.0.0.0/8'
ENV POSTMASTER_MAIL 'postmaster@example.com'
ENV ROOT_MAIL 'root@example.com'

# Mailbox cleanup
ENV CLEANUP_TRASH 30
ENV CLEANUP_SPAM 60

# ===================================================
# Ports
# ===================================================

# SMTP
EXPOSE 25
# SMTPS
EXPOSE 465
# POP
EXPOSE 110
# IMAP
EXPOSE 143
# POPS
EXPOSE 993
# IMAPS
EXPOSE 995
# Sieve
EXPOSE 4190

# ===================================================
# Base packages
# ===================================================

RUN apt-get update && \
    apt-get upgrade -y --no-install-recommends

RUN apt-get install -y --no-install-recommends \
    apt-listchanges \
    apt-transport-https \
    ca-certificates \
	gettext-base \
    unattended-upgrades \
    syslog-ng

# ===================================================
# Postfix
# ===================================================

# Pre-seeding for Postfix installation
RUN echo "postfix postfix/mailname string mail.example.com" | debconf-set-selections && \
	echo "postfix postfix/main_mailer_type string 'No configuration'" | debconf-set-selections

RUN apt-get install -y --no-install-recommends \
    postfix \
    postfix-mysql

# ===================================================
# Dovecot
# ===================================================

RUN apt-get install -y --no-install-recommends \
    dovecot-mysql \
    dovecot-imapd \
    dovecot-pop3d \
    dovecot-sieve \
    dovecot-managesieved \
    libsasl2-modules \
    sasl2-bin

# Create Sieve folder
RUN mkdir -p ${FRX_MAIL_DIR}/.sieve/.before

# ===================================================
# Postfix & Dovecot configuration
# ===================================================

# Create mail user and group
RUN groupadd -g 2000 vmail && \
    useradd -u 2000 -g vmail vmail

# Set rights
RUN chown -R 2000:2000 ${FRX_MAIL_DIR} && \
	chmod -R 0750 ${FRX_MAIL_DIR}

# ===================================================
# SpamAssassin
# ===================================================

RUN apt-get install -y --no-install-recommends \
    spamc

# Create user and group
RUN groupadd debian-spamd && \
    useradd -g debian-spamd debian-spamd

# ===================================================
# Trash & Spam cleanup
# ===================================================

RUN apt-get install -y --no-install-recommends \
	cron

# ===================================================
# Filesystem
# ===================================================

COPY ./src/ /

# ===================================================
# Entrypoint
# ===================================================

ENTRYPOINT ["bash", "/start.sh"]
