#!/bin/bash

MONGODUMP_PATH="" #folder path to download dumped database to
MONGODUMP_USERNAME="" #database username
MONGODUMP_PASSWORD="" #database password
MONGO_URI="" #database string connection e.g mongodb://hostname:port/?replicaSet= (mongodb://127.0.0.1:27017/?replicaSet=rs0)

TIMESTAMP=`date +%F-%H%M`
R2_BUCKET_NAME="" #name of bucket created on cloudflare R2 storage

# Create backup [dump database]
echo "Taking dump and storing in $MONGODUMP_PATH"
cd $MONGODUMP_PATH
mongodump --uri $MONGO_URI -u $MONGODUMP_USERNAME -p $MONGODUMP_PASSWORD --oplog

# Rename folder and compress folder [add hostname and timestamp to backup name]
echo "Making zip of dump created with timestamp..."
mv dump $HOSTNAME-mongodb-$TIMESTAMP
tar cf $HOSTNAME-mongodb-$TIMESTAMP.tar.gz $HOSTNAME-mongodb-$TIMESTAMP

# Upload to R2
echo "Uploading dump to R2..."
rclone copy $MONGODUMP_PATH/$HOSTNAME-mongodb-$TIMESTAMP.tar.gz r2:$R2_BUCKET_NAME

# Delete the backup after sync to R2
echo "removing zipped dump and folder..."
rm -rf $MONGODUMP_PATH/*