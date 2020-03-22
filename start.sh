#!/bin/bash

# Set timezone
ln -snf "/usr/share/zoneinfo/${TZ}" etc/localtime
echo "${TZ}" > /etc/timezone

# Set language
locale-gen "${LOCALE}" && update-locale LANG="${LOCALE}"

# Get config files
r=()
r+=("$(find ${POSTFIX_DIR} -type f -name '*.cf')")
r+=("$(find ${DOVECOT_DIR} -type f -name '*.conf*')")
r+=("$(find ${SPAMASSASSIN_DIR} -type f -name '*.cf')")
r+=("$(find ${CRON_DAILY_DIR} -type f)")

# Replace environment vars
for d in "${r[@]}"
do
	for f in $d
	do
		# Replace only if not mounted as read-only
		if [ -w "$f" ]
		then
			t="$f.tmp"
			mv $f $t
			envsubst < $t > $f
			rm $t
		fi
	done
done

# Set root alias
mv /etc/aliases /etc/aliases.tmp
envsubst < /etc/aliases.tmp > /etc/aliases
rm /etc/aliases.tmp
newaliases

# Fix "Cron in Docker" hardlink count problem
# See https://unix.stackexchange.com/questions/453006/getting-cron-to-work-on-docker
touch /etc/crontab /etc/cron.*/*

# Start logging
service syslog-ng start

# Start Cron
service cron start

# Start Dovecot
service dovecot start

# Start SpamAssassin
service spamassassin start

# Grace time to prevent SASL authentication method error
sleep 10

# Start Postfix
service postfix start

# Show logs
tail -f /var/log/mail.log
