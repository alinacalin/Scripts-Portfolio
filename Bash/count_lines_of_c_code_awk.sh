#!/bin/bash

if [ $# -eq 0 ] || [ ! -d $1 ] || [ ! -r $1 ]
then
    echo "Usage: run with an argument that is a valid directory with read permissions."
    exit 1
fi

awk -f scr.awk $1/*.c

#--------------scr.awk---------------
#  #!/bin/awk -f
#  BEGIN { s=0 }
#  /[^ \t]/  { s+=1 }
#  END {print s}
#------------------------------------
