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
| FRX_MAIL_DIR | `DIRECTORY PATH` | /var/customers/mail | Path to the Froxlor customer mails.
| FRX_DB_HOST | `HOSTNAME` \| `IP` | localhost | Froxlor database hostname or IP
| FRX_DB_NAME | `DATABASE NAME` | froxlor | Froxlor database name
| FRX_DB_USER | `DATABASE USER` | froxlor | Froxlor database user
| FRX_DB_PASSWORD | `DATABSE PASSEWORD` |  | Froxlor database user password
| ROOT_MAIL | `EMAIL` | root@example.com | Email address alias for internal mails to the root user.
| MAIL_DOMAIN | `FQDN` | example.com | Mail domain
| POSTMASTER_MAIL | `EMAIL` | postmaster@example.com | Postmaster email address
| CLEANUP_TRASH | `INTEGER` | 30 | Time in days after mails in Trash folder will be deleted.
| CLEANUP_SPAM | `INTEGER` | 60 | Time in days after mails in Spam folder will be deleted.
| TZ | [PHP: List of supported timezones - Manual](https://www.php.net/manual/en/timezones.php) | Europe/Berlin | Used timezone for date and time calculation.

### Ports

| Port | Protocol | Description
| ---: | -------- | -----------
| 25 | `SMTP` | Receive encrypted and unencrypted emails. A TLS certificate may be required.
| 110 | `POP` | Used to receive emails. The emails are downloaded locally.
| 143 | `IMAP` | Used to receive emails. The e-mails remain on the server.
| 465 | `SMTPS` | Encrypted **ONLY** version of `SMTP`.
| 993 | `POPS` | Encrypted version of `POP`. A TLS certificate is required.
| 995 | `IMAPS` | Encrypted version of `IMAP`. A TLS certificate is required.
| 4190 | `Sieve` | Service for managing rules for receiving and storing e-mails.

### Volumes

| Volume | Path | Read only | Description
| ------ | ---- | :-------: | -----------
| Customer mail | /var/customers/mail/ | &#10006; | Froxlor customer mail content.

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

*[ENV]: Environment Variable
*[FQDN]: Fully Qualified Domain Name
*[IMAP]: Internet Message Access Protocol
*[IP]: Internet Protocol
*[MIT]: Massachusetts Institute of Technology
*[POP]: Post Office Protocol
*[SMTP]: Simple Mail Transfer Protocol
*[TLS]: Transport Layer Security
*[TZ]: Timezone

