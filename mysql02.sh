#!/bin/bash
DB_BACKUP_PATH='/root/mysqlbackup'
HOST_NAME='192.168.42.220'
USER_NAME='root'
PASSWORD='redhat1234'
DATABASE_NAME='erp'

#mkdir -p ${DB_BACKUP_PATH}/${TODAY}


#mysqldump -h ${HOST_NAME} -u ${USER_NAME} -p${PASSWORD} ${DATABASE_NAME} |gzip > ${DB_BACKUP_PATH}/${TODAY}/${DATABASE_NAME}-${TODAY}.sql.gz 

mysqldump -h ${HOST_NAME} -u ${USER_NAME} -p${PASSWORD} ${DATABASE_NAME} | gzip > ${DB_BACKUP_PATH}/${DATABASE_NAME}-`date +"%m%d%Y"`.sql.gz

if [ $? -eq 0 ]
then
echo "backup done"
else
echo "backup not done"
fi

#######################
echo "find $(find "${DB_BACKUP_PATH}"  -type f -mtime +7 -delete )"
