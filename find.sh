#!/bin/bash
#ssh root@192.168.42.217
#scp -r 192.168.42.217:/root/shiv/* /home
ssh root@192.168.42.217 find /root/shiv/* -name "test*.*"  -delete
#ssh root@192.168.42.217 find /root/shiv/*  -delete
#ssh root@192.168.42.217 find /root/shiv/* -type d -delete
#find /root/raj/ -name "shiv*.*" -type d -delete
#exit 1
