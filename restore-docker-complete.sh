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

SCRIPT_PATH_VOLUME="/home/mod/git/paperless-ngx-backup/restore-docker-volume.sh"
SCRIPT_PATH_COMPOSE="/home/mod/git/paperless-ngx-backup/restore-docker-compose.sh"

. "$SCRIPT_PATH_COMPOSE"
. "$SCRIPT_PATH_VOLUME"
