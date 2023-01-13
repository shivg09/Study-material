#!/bin/bash
HOSTNAME=$(hostname)
RESULT=$(sed -ri "sed -ri "s/^PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config)
echo "$HOSTNAME", "$RESULT" >> /opt/sshenable


for i in `cat /root/hostlist`;
do
RHOSTNAME=$(ssh $i hostname) 


RENABLE=$(ssh $i 'sed -i "s/^#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config')
echo "$RHOSTNAME", "$RENABLE" >> /opt/sshenable
done


==============================
Working Script

#!/bin/bash
#HOSTNAME=$(hostname)
sed -ri "s/^PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config
#echo "$RESULT" 
for i in `cat /home/hostlist`;
do
RENABLE=$(ssh $i 'sed -i "s/^PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config')
echo "$RHOSTNAME", "$RENABLE" >> /opt/sshenable
echo "$RESULT", "$RHOSTNAME"
done
~                                                                                                                             
~         
