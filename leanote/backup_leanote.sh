#!/usr/bin/sh
# leanote 文件及数据库备份
# USAGE:
##       backup_leanote password prefix  address >> /var/log/backup_leanote.log 2>&1
##       openssl enc -d -aes256 -in *.tar.gz | tar xz

FILENAME=leanote_mongodb_backup_`date +%Y_%m_%d`
BACKUPDIR=$HOME/.temp/
LEANOTEDIR=/home/cheng/backup/leanote
# mongodump -d leanote -u leanote -p $1 -o $BACKUPDIR$FILENAME
mongodump -d leanote -o $BACKUPDIR$FILENAME
tar -czf - -C $BACKUPDIR $FILENAME | openssl enc -e -aes256 -out $LEANOTEDIR"/mongodb_backup/"$FILENAME".tar.gz" -k $1
rsync -L -arvztpog --delete --progress $LEANOTEDIR cheng@$3:/home/cheng/backup/$2
rm -rvf $BACKUPDIR$FILENAME 
