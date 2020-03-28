#!/bin/bash

# Delete mails older than ${C_DELETE_SPAM} days from all Spam folders
find ${FRX_MAIL_DIR}/*/*/*/.Spam/cur/ -type f -mtime +${CLEANUP_SPAM} -exec rm {} \;
