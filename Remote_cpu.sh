#!/bin/bash

HOSTNAME=$(hostname)
DATE=$(date "+%y-%m-%d %H:%M:%S")
CPUUSAGE=$(top -b -n2 |grep "Cpu(s)" |awk '{print $2}' |awk -F. '{print $1}')

MEMUSAGE=$(free |grep Mem |awk '{print $2 }')
#MEMUSAGE=$(free |grep Mem |awk '{print $3/$2 * 100.0}')
#DISKUSEGE=$(df -P| awk '{print $5}' |tail -n 1 |sed 's/%//g')



echo "$HOSTNAME","$DATE", "$CPUUSAGE","$MEMUSAGE","$DISKUSEGE" >> /opt/cpu
echo "$DISKUSEGE"

for i in `cat /root/hostlist`;

do
RHOSTNAME=$( ssh $i hostname)
#RDATE=$(date "+%y-%m-%d %H:%M:%S")
#RCPUUSAGE=$(ssh $i top -b -n2 |grep "Cpu(s)" |awk '{print $2}' |awk -F. '{print $1}')

RMEMUSAGE=$(ssh $i free |grep Mem |awk '{print $2}')
#RDISKUSEGE=$(ssh $i df -P| awk '{print $5}' |tail -n 1 |sed 's/%//g')

echo "$RHOSTNAME","$RDATE", "$RCPUUSAGE","$RMEMUSAGE","$RDISKUSEGE" >> /opt/cpu
done


=================
Output of ls command
#!/bin/bash
echo "Welcome school"
echo 'shiv'
echo "$(ls)"


===============

root@ip-172-31-35-248:~# cat inventory.sh
#!/bin/bash
server_name=$("hostname")
UP_time=$(uptime |awk '{print $3}')
IP_Address=$(ifconfig |grep inet |awk 'NR==1{print $2}')
echo "$server_name"
echo "$IP_Address"
echo "$UP_time"

echo "1.$server_name,$UP_time,$IP_Address" >> /root/a2.csv
