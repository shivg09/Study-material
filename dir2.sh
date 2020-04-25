#!/bin/bash
for i in *
do
if [ -d $i ] 
then
echo "$i"
else
echo "no files"
fi
done
