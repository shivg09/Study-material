#!//bin/bash
#what to backup
backup="/opt"
#where to backup
dest="/mnt/backup"
day=$(date +%A)
hostname=$(hostname -s) 
archive_file="$hostname-$day.tgz"
echo "backup $backup to $dest/$archive_file"
date
echo
#Backup the files using tar
tar cvzf $dest-$archive_file $backup
echo "backup finised"
