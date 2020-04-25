#!/bin/bash
echo "enter the dir"
read dirname

if [ -d $dirname ]
then 
#cd $dirname
#echo "$(find "$dirname"  -type f |wc -l )"
echo "$(find "$dirname" -name "^out" -type f -exec rm {} \;)"
fi
