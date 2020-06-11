#!/bin/bash
TO="shivprasad.g@apsfl.co.in"
ram_free=$(free -m |grep Total |awk '{print $4}')

if [ $ram_free -le 700 ]
then
    echo "memory less then 700 $ram_free"
fi

