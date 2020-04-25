#!/bin/bash
echo -n "enter the first no"
read first
echo -n "enter the second no"
read second

echo `expr $first + $second`

echo "$sum"
