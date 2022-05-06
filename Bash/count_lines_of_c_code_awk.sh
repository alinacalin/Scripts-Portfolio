#!/bin/bash

awk -f scr.awk $1/*.c

#--------------acr.awk---------------
#  #!/bin/awk -f
#  BEGIN { s=0 }
#  /[^ \t]/  { s+=1 }
#  END {print s}
#------------------------------------
