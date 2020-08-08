#!/bin/bash
for i in `cat /root/hostlist`
do
RHOSTNAME=$(ssh $i hostname)
LOG=$(ssh $i find /var/log/httpd/ -name "access_log*" -type f -mtime +10 -delete) 
#echo "$RHOSTNAME"
if [ $? -eq 0 ]
then
echo " sucessfull"
else
echo "not working"
fi
done
