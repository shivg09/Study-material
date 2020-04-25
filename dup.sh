#!/bin/bash
echo -n "ener filename"
read filename
if [ -f $filename ] 
then
sort -u $filename 
#echo "$output"
fi
