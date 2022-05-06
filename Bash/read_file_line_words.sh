#!/bin/bash

if [ $# -eq 0 ]
then
    echo "Provide an argument filename."
    exit 1
fi

if [ ! -f $1 ]
then
    echo "Argument is not a file."
    exit 1
fi

if [ ! -r $1 ]
then
    echo "File does not have read permissions."
    exit 1
fi


IFS="" # to read to the EOL, field separator is made empty
while read line
do
        echo $line
        #make for to parse word by word, change separator to space
        IFS=" "
        for w in $line
        do
                echo "[$w]  "
        done
        #back to reading line by line, to keep spaces change IFS
        IFS=""
done < $1
#$1 is input file, must be provided as command line argument
