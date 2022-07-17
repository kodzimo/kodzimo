#! /bin/bash

DATE=$(date '+%d-%m-%Y_%H-%M-%S')

sudo mysqldump -u user1 -puser1 -h localhost db1 --result-file=/opt/mysql_backup/db1_backup_"$DATE".sql --no-tablespaces

sudo mysqldump -u user2 -puser2 -h localhost db2 --result-file=/opt/mysql_backup/db2_backup_"$DATE".sql --no-tablespaces

sudo rsync -av /opt/mysql_backup/ /opt/store/mysql
