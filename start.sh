#!/bin/bash

# Set timezone
ln -snf "/usr/share/zoneinfo/${TZ}" etc/localtime
echo "${TZ}" > /etc/timezone

# Get config files
r=()
r+=("$(find /etc -type f -name 'aliases')")
r+=("$(find /etc/postfix -type f -name '*.cf')")
r+=("$(find /etc/dovecot -type f -name '*.conf*')")
r+=("$(find /etc/cron.d -type f -name 'cleanup-*')")

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

# Update root alias
newaliases

service cron start

service dovecot start

# Grace time to prevent SASL authentication method error
sleep 5

service postfix start

# Keep container running
tail -f /dev/null
