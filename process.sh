#!/bin/bash
 ps -e --sort -pcpu -o comm,pcpu,user,pid,pmem |head -n10
ps -e --sort -pcpu -o cmd,pcpu,user,pid |head -n10
