#/bin/bash

DB_BACKUP_PATH='/root/backup-mongo'

mongorestore --gzip --archive=${DB_BACKUP_PATH}/archive.gz
