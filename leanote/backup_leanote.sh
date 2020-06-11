#!/usr/bin/sh
# leanote 文件及数据库备份
# USAGE:
##       backup_leanote password passwd  address >> /var/log/backup_leanote.log 2>&1

FILENAME=leanote_mongodb_backup_`date +%Y_%m_%d`
BACKUPDIR=/tmp/leanote/
LEANOTEDIR=/home/cheng/backup/leanote
mongodump -d leanote -u leanote -p $1 -o $BACKUPDIR$FILENAME
tar -czf - -C $BACKUPDIR $FILENAME | openssl enc -e -aes256 -out $LEANOTEDIR"/mongodb_backup/"$FILENAME".tar.gz" -k $1
rsync -L -arvztpog --delete --progress $LEANOTEDIR cheng@$3:/home/cheng/backup
rm -rvf $BACKUPDIR$FILENAME 
