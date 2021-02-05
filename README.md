[![Release](https://img.shields.io/github/v/release/bloodhunterd/froxlor-mail?style=for-the-badge)](https://github.com/bloodhunterd/froxlor-mail/releases)
[![Docker Build](https://img.shields.io/github/workflow/status/bloodhunterd/froxlor-mail/Docker?style=for-the-badge&label=Docker%20Build)](https://github.com/bloodhunterd/backup/actions?query=workflow%3ADocker)
[![Docker Pulls](https://img.shields.io/docker/pulls/bloodhunterd/froxlor-mail?style=for-the-badge)](https://hub.docker.com/r/bloodhunterd/froxlor-mail)
[![License](https://img.shields.io/github/license/bloodhunterd/froxlor-mail?style=for-the-badge)](https://github.com/bloodhunterd/froxlor-mail/blob/master/LICENSE)

[![ko-fi](https://www.ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/bloodhunterd)

# Froxlor Mail Docker

Docker image of Postfix and Dovecot for Froxlor Server Management Panel.

*This image is meant to be used with the [Froxlor](https://github.com/bloodhunterd/froxlor) image.*

## Deployment

### Docker Compose

```dockerfile
version: '2.4'

services:
  mail:
    image: bloodhunterd/froxlor-mail
    environment:
      TZ: 'Europe/Berlin'
      FRX_MAIL_DIR: '/var/customers/mail'
      FRX_DB_HOST: 'localhost'
      FRX_DB_NAME: 'froxlor'
      FRX_DB_USER: 'froxlor'
      FRX_DB_PASSWORD: '+V3ryS3cr3tP4ssw0rd#'
      MAIL_DOMAIN: 'example.com'
      POSTMASTER_MAIL: 'postmaster@example.com'
      ROOT_MAIL: 'root@example.com'
    restart: unless-stopped
    ports:
      - '25:25'
      - '110:110'
      - '143:143'
      - '465:465'
      - '993:993'
      - '995:995'
      - '4190:4190'
    volumes:
      - ./mail:/var/customers/mail/
```

### Configuration

| ENV | Values | Default | Description
| --- | ------- | ------- | -----------
| FRX_MAIL_DIR | *Directory path* | /var/customers/mail | Path to the Froxlor customer mails.
| FRX_DB_HOST | *Hostname / IP* | localhost | Froxlor database hostname or IP
| FRX_DB_NAME | *Database name* | froxlor | Froxlor database name
| FRX_DB_USER | *Database user* | froxlor | Froxlor database user
| FRX_DB_PASSWORD | *Database user password* |  | Froxlor database user password
| ROOT_MAIL | *Any valid email address* | root@example.com | Email address alias for internal mails to the root user.
| MAIL_DOMAIN | *FQDN* | example.com | Mail domain
| POSTMASTER_MAIL | *Any valid email address* | postmaster@example.com | Postmaster email address
| CLEANUP_TRASH | 0 - ... | 30 | Time in days after mails in Trash folder will be deleted.
| CLEANUP_SPAM | 0 - ... | 60 | Time in days after mails in Spam folder will be deleted.
| TZ | [PHP: List of supported timezones - Manual](https://www.php.net/manual/en/timezones.php) | Europe/Berlin | Used timezone for date and time calculation.

### Ports

| Port | Description
| ---: | -----------
| 25 | SMTP
| 110 | POP
| 143 | IMAP
| 465 | SMTPS
| 993 | POPS
| 995 | IMAPS
| 4190 | Sieve

### Volumes

| Volume | Path | Read only | Description
| ------ | ---- | :-------: | -----------
| Customer mail | /var/customers/mail/ | &#10008; | Froxlor customer mail content.
| Mail log | /var/log/mail.log | &#10008; | Mail log. *Won't be rotated by default.*

| &#10004; Yes | &#10008; No
| ------------ | -----------

## Update

Please note the [changelog](https://github.com/bloodhunterd/froxlor-mail/blob/master/CHANGELOG.md) to check for configuration changes before updating.

```bash
docker-compose pull
docker-compose up -d
```

## Build With

* [Postfix](http://www.postfix.org/)
* [Dovecot](https://www.dovecot.org/)
* [Debian](https://www.debian.org/)
* [Docker](https://www.docker.com/)

## Authors

* [BloodhunterD](https://github.com/bloodhunterd)

## License

This project is licensed under the MIT - see [LICENSE.md](https://github.com/bloodhunterd/froxlor-mail/blob/master/LICENSE) file for details.
