#!/bin/bash
#Cound the number of non-empty lines of C code in the directory provided as cmd line arg.

if [ $# -eq 0 ]
then
    echo "Provide an argument."
    exit 1
fi

if [ ! -d $1 ] || [ ! -r $1 ]
then
    echo "The argument must be a valid directory with read permissions."
    exit 1
fi

DIR=$1
S=0

for F in `find $DIR -type f -name "*.c"`
do
        echo $F
        N=`grep -E -v -c "^$" $F`
        echo $N
        S=`expr  $S + $N`
done

echo $S
