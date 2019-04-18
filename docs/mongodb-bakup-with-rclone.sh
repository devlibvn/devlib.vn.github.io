#!/bin/bash
# configuration
SERVER_NAME=""

TIMESTAMP=$(date +%Y%m%d)

BACKUPS_DIR="/home/ubuntu/mongodbbackup"

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

rclone move $ZIP_FOLDER_NAME "remote:$TARGET_FOLDER"
