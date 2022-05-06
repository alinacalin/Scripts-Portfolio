#!/bin/sh
if [ $# -eq 0 ]
then
    echo "Provide an argument a C file."
    exit 1
fi

if find $1 -type f -name "*.c" 2>/dev/null
then
    echo "Compiling $1 with option -Wall:"
else
    echo "$1 is not a C file."
    exit 1
fi


if gcc -Wall -o myprog -Wall $1
then
        shift
        ./myprog $*
else
        echo "Compile errors:"
fi
