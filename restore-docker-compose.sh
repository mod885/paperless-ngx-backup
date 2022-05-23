#https://www.laub-home.de/wiki/Docker_Backup_und_Restore_-_eine_kleine_Anleitung
# zuerst das richtige Datum der Restore Dateien wählen, 
# sollte im besten Fall das letzt Verfügbare Datum sein
# also den Timestamp (YYYYMMDD) setzen
TIMESTAMP=20220506
# dann ins Verzeichniss wechseln
cd /home/mod/paperless-ngx-backup/compose
# Und dann alles entpacken (/opt/COMPOSEPROJEKT)
for i in $(ls *${TIMESTAMP}*); do mkdir /media/extreme/${i%%_*} && tar -xzvf ${i} -C /media/extreme/${i%%_*}; done
#start container
for i in $(ls *${TIMESTAMP}*); do cd /media/extreme/${i%%_*} && docker-compose up -d; done

