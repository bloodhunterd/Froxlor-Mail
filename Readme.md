[![Release](https://img.shields.io/github/v/release/bloodhunterd/froxlor-mail-docker?include_prereleases&style=for-the-badge)](https://github.com/bloodhunterd/froxlor-mail-docker/releases)
[![Docker Build](https://img.shields.io/docker/cloud/build/bloodhunterd/froxlor-mail?style=for-the-badge)](https://hub.docker.com/r/bloodhunterd/froxlor-mail)
[![License](https://img.shields.io/github/license/bloodhunterd/froxlor-mail-docker?style=for-the-badge)](https://github.com/bloodhunterd/froxlor-mail-docker/blob/master/LICENSE)

# Froxlor Mail

Docker image for Froxlor Mail Server.

*This image is meant to be used with the [Froxlor Docker](https://github.com/bloodhunterd/froxlor-docker) image.*

## Configuration

Download, rename and adjust the Docker Compose distribution file.

[![Docker Compose](https://img.shields.io/github/size/bloodhunterd/froxlor-mail-docker/docker-compose.dist.yml?label=Docker%20Compose&style=for-the-badge)](https://github.com/bloodhunterd/froxlor-mail-docker/blob/master/docker-compose.dist.yml)

### Environment

| ENV | Values¹ | Default | Description
|--- |--- |--- |---
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

¹ *Possible values are separated by a slash. A range is indicated by a dash.*

### Volumes

Access to Froxlor mail directory.

```bash
volumes:
  - ./mail/:/var/customers/mail/
```

Mount mail log².

```bash
volumes:
  - ./mail.log:/var/log/mail.log
```

² Won't be rotated by default.

## Update

Please note the [changelog](https://github.com/bloodhunterd/froxlor-mail-docker/blob/master/CHANGELOG.md) to check for configuration changes before updating.

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

This project is licensed under the MIT - see [LICENSE.md](https://github.com/bloodhunterd/froxlor-mail-docker/blob/master/LICENSE) file for details.
