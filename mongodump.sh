#!/bin/bash

cd /root

rm -rf dump

DATE=$(date +"%Y-%m-%d")
EXPIRE=$(date -d "30 days ago" +"%Y-%m-%d")

DB="db"
AUTH="--authenticationDatabase "admin"  --username apiuser --password 123"

BUCKET="s3://dump-mongo/production"

COLLECTIONS=$(mongo  $DB $AUTH  -quiet -eval "db.getCollectionNames().forEach(function(d){print(d)})")

for COL in $COLLECTIONS; do

    if [ $COL == "communications" ]; then
        continue
    fi

    mongodump -d $DB $AUTH -c $COL --gzip

    aws s3 cp "dump/$DB/$COL.bson.gz" "$BUCKET/$DATE-$COL.bson.gz"
    aws s3 cp "dump/$DB/$COL.metadata.json.gz" "$BUCKET/$DATE-$COL.metadata.json.gz"

    aws s3 rm "$BUCKET/$EXPIRE-$COL.bson.gz"
    aws s3 rm "$BUCKET/$EXPIRE-$COL.metadata.json.gz"
done