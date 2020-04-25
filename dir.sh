#!/bin/bash
if [ -d "$@" ]
then
#echo "file found $(find "$@" -type f |wc -l )" 
#echo "file found $(find "$@" -type f -exec rm {} \; )" 
#echo "dir found $(find "$@" -type d )"
echo "file found $(find "$@" -type f -delete )"
else
echo "retry with other folder"
exit 1
fi
