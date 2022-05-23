# backup_docker_scripts
with these script you are able to backup your docker environment. There is one for the compose project, for one mysql or mariadb, one for postgres SQL and one for the docker volumes.

# restore_docker_scripts
with these script you are able to restore your docker environment if you used the backup scripts. There is one for the compose project and one for the docker volumes.

# Installation
Just download the needed Script/s to `/usr/local/sbin` and give them the excute (`chmod +x SCRIPTNAME`) then you could just start it from wherever you are in the filesystem.

# Usage
## backup-docker-volume.sh
This Script backups docker volumes of the system to a defined Path. You could define the volumes and the backup path in the script itself. Also you could configure the days, how long the backup files will remain as backup. After configuration of the script, you could just start it with:

`backup-docker-volume.sh`

## backup-docker-compose.sh
With the help of `backup-docker-compose.sh` you are able to backup the whole docker-compose project folder of each docker-compose project you are running. It uses `tar.gz` to archive all the files and folders to the predifined backup folder. Just configure the script in the top and run it:

`backup-docker-compose.sh`

You can also configure the days, the backupfiles will remain in the backup folder.

## restore-docker-compose.sh
With the help of `restore-docker-compose.sh` you are able to restore the whole docker-compose project folder. Just configure the script with the timestamp, the folder with the compose backup (tar.gz) and your project destination folder. Then run it:

`restore-docker-compose.sh`

## restore-docker-volume.sh
This Script restores the docker volumes. You need to configure the timestamp, the folder with the volume backup (tar.gz) and at the end your project folder of the docker-compose project. After configuration of the script, you could just start it with:

`restore-docker-volume.sh`

## order of execution
### backup
first run the volume, second the compose script

### restore
first run the compose, second the volume script

# More Informations you could find here:
* https://www.laub-home.de/wiki/Docker_Backup_und_Restore_-_eine_kleine_Anleitung
* https://www.laub-home.de/wiki/Docker_Postgres_Backup_Script
* https://www.laub-home.de/wiki/Docker_InfluxDB_2_Backup_Script
* https://www.laub-home.de/wiki/Docker_Volume_Backup_Script
* https://www.laub-home.de/wiki/Docker_MySQL_and_MariaDB_Backup_Script
* https://www.laub-home.de/wiki/Docker_Compose_Project_Backup_Script
