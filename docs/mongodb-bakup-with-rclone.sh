#!/bin/bash
# configuration
SERVER_NAME=""

TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)

BACKUPS_DIR="/backups"

DB_USER=""

DB_PASSWORD=""

AUTH_DB=""

OUT_FOLDER_NAME="db-$TIMESTAMP"

ZIP_FOLDER_NAME="$OUT_FOLDER_NAME.zip"

TARGET_FOLDER=""

# execute

cd $BACKUPS_DIR

mongodump --authenticationDatabase $AUTH_DB --username $DB_USER --password $DB_PASSWORD -h localhost --out $OUT_FOLDER_NAME

zip -r $ZIP_FOLDER_NAME $OUT_FOLDER_NAME -q
rm -rf $OUT_FOLDER_NAME

/usr/sbin/rclone move $ZIP_FOLDER_NAME "remote:$TARGET_FOLDER" >> /var/log/rclone.log 2>&1
