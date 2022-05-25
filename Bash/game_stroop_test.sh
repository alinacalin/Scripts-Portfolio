#!/bin/bash
# Copyright @ Alina 2022
# This scripts implements a simple version of the stroop test challenge as a game.
# Your task is to identify if the font color matches the color described by the word.
# And be really fast. 

colorlist=("RED" "BLUE" "GREEN")
fontlist=('\033[0;31m' '\033[0;34m' '\033[0;32m')
no_of_colors=${#colorlist[@]}

# level 1 settings: todo implement more levels
sec_per_word=2
sec_per_session=30

points=0
corr=""
level=1

NC='\033[0m' #No color to change back to neutral

RANDOM=$$    #Initialise random seed


# stroop test play function generates random colors and fonts and keeps score

function play_stroop(){

        clear
        printf '|%32.32s|' "Previous was: $corr "   "TOTAL: $points points"
        echo
        echo -e "\nIs the font color the same as the word meaning? Answer yes[y]/no[n].\n"
        c=`expr $RANDOM % $no_of_colors`
        f=`expr $RANDOM % $no_of_colors`
        printf  '%-20.20s'"       ${fontlist[$f]}${colorlist[$c]}${NC}   \n"
        echo -n ">>>"
        read -n1 -t 2 ans
        if [ "$ans" == "y" ] && [ $c -eq $f ]
        then
                corr="Correct! +1p"
                #echo -e "\nCorrect! +1p\n"
                points=`expr $points + 1`
        elif [ "$ans" == "n" ] && [ $c -ne $f ]
        then
                corr="Correct! +1p"
                points=`expr $points + 1`
        else
                corr="Incorrect..."
                #echo -e "\nIncorrect!"
        fi

}


function demo(){
        echo -e "\nHow to play the game?\n"
        sleep 1
        echo -e "\nIs the font color the same as the word meaning? Answer yes[y]/no[n].\n"
        sleep 1
        printf  '%-20.20s'"       ${fontlist[0]}${colorlist[0]}${NC}   \n"
        sleep 1
        echo "In this case the word is ${colorlist[0]}, just like the font color."
        echo "The answer is yes, so type y:"
        echo -n ">>>"
        while read -n1 ans
        do
                if [ $ans != "y" ]
                then
                        echo "The answer is yes, so type y:"
                        echo -n ">>>"
                else
                        break
                fi
        done
        echo -e "\n  Well done! Now let's see an other example.\n"
        sleep 1

        echo -e "\nIs the font color the same as the word meaning? Answer yes[y]/no[n].\n"
        sleep 1
        printf  '%-20.20s'"       ${fontlist[2]}${colorlist[1]}${NC}   \n"
        sleep 1

        echo "In this case they are different: the word is ${colorlist[1]}, but the font color is ${colorlist[2]}."
        echo "The answer is no, so type n:"
        echo -n ">>>"

        while read -n1 ans
        do
                if [ $ans != "n" ]
                then
                        echo "The answer is yes, so type y:"
                        echo -n ">>>"
                else
                        break
                fi
        done

        echo -e "\n  Well done! You have completed the Demo tutorial!\n"
        echo "Press Enter to go back to MENU..."
        read ans
        menu
}

# Display MENU with Play, Demo and Exit options

function menu(){
        clear

        echo -e "\n           ******************* STROOP GAME ******************         \n"
        echo -e "\n This game will challenge you greatly. Are you ready? \n"
        echo -e "\n You will see a word on the screen, representing a color. You have to determine if the meaning of the word matches with the font color. Asnwer with yes (y) or no (n) by typing letters y or n. Each correct answer will award you 1 point. You have $sec_per_word seconds to provide the answer before the next word will appear. Try to answer correctly as many as possible within the time limit. \n"
        echo -e "\n\n     Good luck! \n\n"
        echo -e "            **************************************************          "
        echo -e "\n                       MENU \n"
        echo -e "              Demo Tutorial : Hit D \n"
        echo -e "              Play Game     : Hit P \n"
        echo -e "              Exit Game     : Hit E \n"
        echo -e "            **************************************************          "
        read -n1 ans

        case "$ans" in
                "D") clear ; #echo "Sorry. Demo not implemented yet.\n"
                        #       echo -e "\n\n\n MENU \n"
                        #       echo -e "Play : Hit P \n"
                        #       echo -e "Exit : Hit E \n"
                        #echo -e "\nEnter to do back to MENU...\n"
                        #read  ans2
                        demo
                        ;;
                "P")clear;
                        echo -e "Ready ..."
                        sleep 1
                        echo -e "Steady ..."
                        sleep 1
                        echo -e "Go! \n"
                        sleep 1
                        points=0
                        corr=""

                        start=$SECONDS
                        while [ $(( SECONDS - start )) -lt $sec_per_session ]
                        do
                                play_stroop
                        done
                        clear
                        echo -e "\nTime's up. Well done! You have obtained $points points!\n"
                        echo -e "\nPress Enter to go back to MENU...\n"
                        read ans
                        menu

                        ;;
                "E")clear; echo -e "\n Goodbye! Have a colorful day!  \n "
                        sleep 1
                        exit 0
                        ;;
                *) menu
                        ;;
        esac
}

# Start game by displaying welcome message and menu

menu
