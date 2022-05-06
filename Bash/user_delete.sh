#!/bin/bash

if [ $# -eq 0 ]
then
        echo "Provide an argument username to delete."
        exit 1
fi

if grep -q -w $1 /etc/passwd 2>/dev/null
then
        echo "Are you sure you want to start removal procedure for user $1?[Y/n]"
        read ans
        if [ "$ans" != "Y" ]
        then
                echo "Cancelled user deletion."
                exit 0
        else
                echo "A report with the user $1's files are storead into reportfile.txt located in $(pwd)."
                echo "This will take a while, please wait..."
                echo "It is recommended to back-up files and than to delete them or change ownership."
                find / -user $1 > reportfile.txt 2>/dev/null

                read -p "Do you wish to make a copy of the home foler? [Y/n]" cpy
                if [ "$cpy" == "Y" ]
                then
                        echo "Copying home folder of $1 into /tmp/$1..."
                        #we have a valid user, we first save home folder data
                        homedir=$(grep -w /etc/passwd | awk -F: '{print $6}')
                        cp -r $homedir /tmp/$1
                fi
                #processes runiing
                echo "User $1 has the following processes runing:"
                ps -u $1
                echo "Would you like to kill all processes?[Y/n]"
                read resp
                if [ "$resp" != "Y" ]; then
                        echo "Processes not killed. Canceling user deletion."
                        exit 0
                else
                        echo "Killing all processes..."
                        ps -u $1 --no-heading | awk '{print$1}' |xargs -d \\n /usr/bin/sudo /bin/kill -9
                        echo "Processes killed."
                        echo
                        echo "Are you sure you want to remove user $1 and all its data from the system? [Y/n]"
                        read final
                        if [ "$final" != "Y" ]
                        then
                                echo "Canceling user deletion."
                                exit 0
                        else
                                #detelete user
                                userdel -f $1
                                echo "User $1 and all its data have been remved from the system."
                        fi
                fi
        fi
else
        echo "The username does not exist."
        exit 1
fi
