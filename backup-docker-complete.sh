#!/usr/bin/env bash
#########################################################################
#Name: backup-docker-compose.sh
#https://www.laub-home.de/wiki/Docker_Backup_und_Restore_-_eine_kleine_Anleitung
#Subscription: This Script backups the docker compose project folder
#to a backup directory
##by A. Laub
#andreas[-at-]laub-home.de
#
#License:
#This program is free software: you can redistribute it and/or modify it
#under the terms of the GNU General Public License as published by the
#Free Software Foundation, either version 3 of the License, or (at your option)
#any later version.
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
#or FITNESS FOR A PARTICULAR PURPOSE.
#########################################################################

# Where to store the Backup files?
ROOTBACKUPDIR=/home/mod/paperless-ngx-backup

# How many Days should a backup be available?
DAYS=2

# Timestamp definition for the backupfiles (example: $(date +"%Y%m%d%H%M") = 20200124-2034)
TIMESTAMP=$(date +"%Y%m%d%H%M")

# Which Docker Compose Project you want to backup?
# Docker Compose Project pathes separated by space 
#COMPOSE="/opt/project1 /opt/project2"
# you can use the following two big command to read out all compose projects
# uncommend if you like to read automatic all projects:
ALLCONTAINER=$(docker ps --format '{{.Names}}')
ALLPROJECTS=$(for i in ${ALLCONTAINER}; do docker inspect --format '{{ index .Config.Labels "com.docker.compose.project.working_dir"}}' ${i}; done | sort -u)
# then to use all projects without filtering it:
#COMPOSE=${ALLPROJECTS}
# you can filter all Compose Projects with grep (include only) or grep -v (exclude) or a combination
# to do a filter for 2 or more arguments separate them with "\|"
# example: $(echo ${ALLPROJECTS} |grep 'project1\|project2' | grep -v 'database')
# to use volumes with name project1 and project2 but not database
#COMPOSE=$(echo -e "${ALLPROJECTS}" | grep 'project1\|project2' | grep -v 'database')
COMPOSE=$(echo -e "${ALLPROJECTS}" | grep -v 'mailcow-dockerized')

#docker-compose pause
echo -e "Pause Compose Projects:\n"
for i in ${COMPOSE}; do
        PROJECTNAME=${i##*/}
		echo -e "  * Projektname: ${PROJECTNAME} \n  * Ordner: ${i}";		
        cd ${i}
		docker-compose pause
done

SCRIPT_PATH_VOLUME="/home/mod/git/paperless-ngx-backup/backup-docker-volume.sh"
SCRIPT_PATH_COMPOSE="/home/mod/git/paperless-ngx-backup/backup-docker-compose.sh"

. "${SCRIPT_PATH_VOLUME}" "${ROOTBACKUPDIR}" "${DAYS}" "${TIMESTAMP}"
. "${SCRIPT_PATH_COMPOSE}" "${ROOTBACKUPDIR}" "${DAYS}" "${TIMESTAMP}"

#docker-compose unpause
echo -e "Unpause Compose Projects:\n"
for i in ${COMPOSE}; do
        PROJECTNAME=${i##*/}
		echo -e "  * Projektname: ${PROJECTNAME} \n  * Ordner: ${i}";
        cd ${i}
		docker-compose unpause
done

cd ${ROOTBACKUPDIR}
echo -e "Creating compressed file of volume and compose directory..."
tar -czf ${ROOTBACKUPDIR}/paperless-ngx_${TIMESTAMP}.tar.gz .
echo -e "\nMove Backup file to my mounted hdd (I do not want any backup on my raspberry)"
mv "${ROOTBACKUPDIR}/paperless-ngx_${TIMESTAMP}.tar.gz" "/media/extreme/OneDriveSync/2FA & Backup/paperless-ngx/backups/"
echo -e "Clean up local backup directory (I do not want any backup files on my raspberry)"
find "${ROOTBACKUPDIR}" -name "*.tar.gz" -type f -delete
echo -e "Clean up mounted hdd backup directory"
OLD_BACKUPS=$(ls -1 /media/extreme/OneDriveSync/2FA\ \&\ Backup/paperless-ngx/backups/*.tar.gz |wc -l)
if [ ${OLD_BACKUPS} -gt ${DAYS} ]; then
		find /media/extreme/OneDriveSync/2FA\ \&\ Backup/paperless-ngx/backups/ -name "*.tar.gz" -daystart -mtime +${DAYS} -delete
fi