#!/bin/bash

DB_BACKUP_PATH='/root/backup-mongo'

DATABASE_NAME='yourDB'
KEY_LOCATION='/root/yourPrivateKey.pem'

# Instance Remote Host

MONGO_REMOTE_HOST='192.168.1.2'

echo "Backup started for database - ${DATABASE_NAME}"

mongodump --db ${DATABASE_NAME} --gzip --archive=${DB_BACKUP_PATH}

if [ $? -eq 0 ]; then
  echo "Database backup successfully completed"
else
  echo "Error found during backup"
fi

### Transfer file backup ###

echo "Transfer Backup to Remote Server"

scp -i ${KEY_LOCATION} ${DB_BACKUP_PATH}/archive.gz root@${MONGO_REMOTE_HOST}:${DB_BACKUP_PATH}

### Restore ###

echo "Restore started for database - ${DATABASE_NAME} on ${MONGO_REMOTE_HOST}"

ssh -i ${KEY_LOCATION} -t root@${MONGO_REMOTE_HOST} '/root/restore-mongo.sh'

if [ $? -eq 0 ]; then
  echo "Database restore successfully completed"
else
  echo "Error found during backup"
fi
