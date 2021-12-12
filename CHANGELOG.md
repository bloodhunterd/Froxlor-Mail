# Changelog

All notable changes will be documented in this file.

<a name="v0.9.0"></a>
## [0.9.0](https://github.com/bloodhunterd/froxlor-mail/releases/tag/0.9.0) &#9839; 12.12.2021

* Updated **Debian** version to 11 (*bullseye*)
* Updated **Postfix** version to 3.5.6
* Updated **Dovecot** version to 2.3.13

<a name="v0.8.0"></a>
## [0.8.0](https://github.com/bloodhunterd/froxlor-mail/releases/tag/0.8.0) &#9839; 25.05.2021

* Replaced foregrounded tail command by postfix running in foreground mode.
* Syslog removed and set logging to `STDOUT` for Postfix.

<a name="v0.7.4"></a>
## [0.7.4](https://github.com/bloodhunterd/froxlor-mail/releases/tag/0.7.4) &#9839; 10.09.2020

* Possible DNS problems fixed
* Froxlor database handling updated
* Postfix message size limit added as environment variables
* Environment variables `POSTMASTER_ADDRESS` and `ROOT_ALIAS` renamed to `POSTMASTER_MAIL` and `ROOT_MAIL`

<a name="v0.7.3"></a>
## [0.7.3](https://github.com/bloodhunterd/froxlor-mail/releases/tag/0.7.3) &#9839; 24.08.2020

* Logrotate removed to fix syslog warnings
* Unneeded apt-utils removed

<a name="v0.7.2"></a>
## [0.7.2](https://github.com/bloodhunterd/froxlor-mail/releases/tag/0.7.2) &#9839; 19.08.2020

* Fix syslog logrotate warnings

<a name="v0.7.1"></a>
## [0.7.1](https://github.com/bloodhunterd/froxlor-mail/releases/tag/0.7.1) &#9839; 14.08.2020

* Fix missing mail log

<a name="v0.7.0"></a>
## [0.7.0](https://github.com/bloodhunterd/froxlor-mail/releases/tag/0.7.0) &#9839; 14.08.2020

* Fix mounting of mail log 
* Fix syslog error notification
* License changed to MIT

<a name="v0.6.0"></a>
## [0.6.0](https://github.com/bloodhunterd/froxlor-mail/releases/tag/0.6.0) &#9839; 06.05.2020

* Scheduled cleanup of trash and Spam folders.
* Missing user for SpamAssassin

<a name="v0.5.0"></a>
## [0.5.0](https://github.com/bloodhunterd/froxlor-mail/releases/tag/0.5.0) &#9839; 11.04.2020

* Spamc installed to use external SpamAssassin

<a name="v0.4.0"></a>
## [0.4.0](https://github.com/bloodhunterd/froxlor-mail/releases/tag/0.4.0) &#9839; 30.03.2020

* SpamAssassin removed due own SpamAssassin Docker image

<a name="v0.3.0"></a>
## [0.3.0](https://github.com/bloodhunterd/froxlor-mail/releases/tag/0.3.0) &#9839; 28.03.2020

* Schedule of trash and Spam cleanup

<a name="v0.2.0"></a>
## [0.2.0](https://github.com/bloodhunterd/froxlor-mail/releases/tag/0.2.0) &#9839; 22.03.2020

* Postgrey removed due own Postgrey Docker image

<a name="v0.1.0"></a>
## [0.1.0](https://github.com/bloodhunterd/froxlor-mail/releases/tag/0.1.0) &#9839; 17.02.2020

* OpenDKIM removed due configuration problems
* Persistent default Sieve rules for Spam
* No multiple Locale generation
* Scheduled trash and Spam deletion
* No missing SASL authentication method at startup

*[DNS]: Domain Name System
*[MIT]: Massachusetts Institute of Technology
*[SASL]: Simple Authentication and Security Layer
