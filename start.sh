#!/bin/bash

# Set timezone
ln -snf "/usr/share/zoneinfo/${TZ}" etc/localtime
echo "${TZ}" > /etc/timezone

# Set locales
echo "${LOCALE}" >> /etc/locale.gen
locale-gen

# Get config files
r[0]=$(find ${PF_DIR} -name '*.cf')
r[1]=$(find ${DC_DIR} -name '*.conf*')
r[2]=$(find ${SA_DIR} -name '*.cf')

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

# Start logging
service syslog-ng start

# Start Cron
service cron start

# Start Dovecot
service dovecot start

# Start SpamAssassin
service spamassassin start

# Start Postgrey
service postgrey start

# Start Postfix
service postfix start

# Show logs
tail -f /var/log/mail.log
