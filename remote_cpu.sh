#!/bin/bash
for i in `cat /root/hostlist`
do
rhostname=$(ssh $i hostname)
cpu_detail=$(ssh $i df -Ph |egrep -v "Filesystem"|awk '{if ($5 > 15) print $0}')
echo "$rhostname" >> /opt/cpuoutput.csv
echo "$cpu_detail" >> /opt/cpuoutput.csv

done

