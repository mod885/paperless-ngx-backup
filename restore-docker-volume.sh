#https://www.laub-home.de/wiki/Docker_Backup_und_Restore_-_eine_kleine_Anleitung
# zuerst das richtige Datum der Restore Dateien wählen, 
# sollte im besten Fall das letzt Verfügbare Datum sein
# also den Timestamp (YYYYMMDD) setzen
TIMESTAMP=20220506
# dann ins Verzeichniss wechseln
cd /home/mod/paperless-ngx-backup/volumes
# dann den restore anstoßen
for i in $(ls *${TIMESTAMP}*); do 
    docker run --rm \
        -v /home/mod/paperless-ngx-backup/volumes:/backup \
        -v ${i%%-[0-9]*}:/data \
        debian:stretch-slim bash -c "cd /data && /bin/tar -xzvf /backup/${i}"
done

for i in $(find /media/extreme -iname "docker-compose.yml"); do cd ${i%/*} && docker-compose restart; done