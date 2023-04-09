#!/bin/bash
echo -n "enter the first no"
read first
echo -n "enter the second no"
read second

echo `expr $first + $second`

echo "$sum"
===========================

#!/bin/bash

echo "enter the value of a:"
read a
echo "enter the value of b:"
read b

sum=$((`expr $a + $b `))
echo "=========================="
echo "Sum value=$sum"
~
