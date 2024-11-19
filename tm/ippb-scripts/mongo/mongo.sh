#!/bin/bash

dbs=("ippb" )

DATE_DIR=$(date +%Y-%m)
DAY_DIR=$(date +%d)

mkdir -p "ippb_db_backup/${DATE_DIR}/${DAY_DIR}"

for db in ${dbs[@]}
do
  echo "Taking dump for $db"
  mongodump -h server-hostname --port 27017 -u username --password password --forceTableScan -d $db --authenticationDatabase admin --gzip --archive="ippb_db_backup/${DATE_DIR}/${DAY_DIR}/$db.dump.gz"
  state=`echo $?`
done

/usr/local/bin/aws s3 cp ippb_db_backup s3://ippb-migration-dump/mongo/b2b/ --recursive --region ap-south-1 #for B2B

/usr/local/bin/aws s3 cp ippb_db_backup s3://ippb-migration-dump/mongo/b2c/ --recursive --region ap-south-1 #for B2C

