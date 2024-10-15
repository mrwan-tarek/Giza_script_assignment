#!/bin/bash
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="/home/ec2-user/BACKUPS/mysql-backup-${TIMESTAMP}.tar.gz"

mkdir -p "/home/ec2-user/BACKUPS"

tar -czvf "${BACKUP_FILE}" -C "/var/lib/docker/volumes/code_mysql-data" .

echo "Backup completed successfully."