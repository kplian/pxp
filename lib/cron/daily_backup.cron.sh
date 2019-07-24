#!/bin/sh
#vars
DATE=$(date +"%Y%m%d%H%M")
#Directory to create backup
BACKUPS_PATH="/var/www/html/backupBD"
#Directory where backups are stored
SERVER_BACKUPS_PATH="/var/www/html/etr/uploaded_files/backupBD"
#name BD
DB=dbetr
# Generating dump and create file.dump
pg_dump $DB -U postgres -F c -b -N log -f "${BACKUPS_PATH}/${DB}_${DATE}" 
#Compress dump size
gzip "${BACKUPS_PATH}/${DB}_${DATE}"
#Copying to nfs and deleting locally
cp -rf "${BACKUPS_PATH}/${DB}_${DATE}.gz" $SERVER_BACKUPS_PATH
rm "${BACKUPS_PATH}/${DB}_${DATE}.gz"