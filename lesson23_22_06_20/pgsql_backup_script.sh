#! /bin/bash

DATE=$(date '+%d-%m-%Y_%H-%M-%S')

sudo pg_dump -U user1 -h localhost db1 -f /opt/postgresql_backup/db1_backup_"$DATE".sql

sudo pg_dump -U user2 -h localhost db2 -f /opt/postgresql_backup/db2_backup_"$DATE".sql

sudo rsync -av /opt/postgresql_backup/ /opt/store/postgres
