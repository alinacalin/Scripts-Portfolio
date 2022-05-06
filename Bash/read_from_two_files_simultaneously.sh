#!/bin/bash

if [ $# -lt 2 ]
then
    echo "Provide two arguments which are filenames."
    exit 1
fi

if [ ! -f $1 ] || [ ! -f $2 ]
then
    echo "Provide two arguments which are filenames."
    exit 1
fi

if [ ! -r $1 ] || [ ! -r $2 ]
then
    echo "Files require read permissions."
    exit 1
fi


file1=$1
file2=$2

exec 3<$file1
exec 4<$file2

while read line1 <&3 && read line2 <&4
do
        echo "file1: $line1"
        echo "file2: $line2"
done

# Read from two files simultaneously and print the lines. Reading stops when one of the files reaches the end of the file.
