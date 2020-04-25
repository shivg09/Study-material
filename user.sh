#!/bin/bash
echo "enter the username"
read user

if grep "$user" /etc/passwd 
then
if who | grep $user > /dev/null
then
echo "user login"
else
echo "user not loggged in"
fi
else
echo "user not exist"
fi
