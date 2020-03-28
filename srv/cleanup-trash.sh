#!/bin/bash

# Delete mails older than ${C_DELETE_TRASH} days from all Trash folders
find ${FRX_MAIL_DIR}/*/*/*/.Trash/cur/ -type f -mtime +${CLEANUP_TRASH} -exec rm {} \;
