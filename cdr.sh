#!/bin/bash
# cdr.sh - Extension to cd that allows for bookmarking locations

# Text color variables
txtund=$(tput sgr 0 1)          # Underline
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) #  red
bldgrn=${txtbld}$(tput setaf 2) #  green
bldblu=${txtbld}$(tput setaf 4) #  blue
bldwht=${txtbld}$(tput setaf 7) #  white
txtrst=$(tput sgr0)             # Reset
info=${bldwht}*${txtrst}        # Feedback
pass=${bldblu}*${txtrst}
warn=${bldred}*${txtrst}
ques=${bldblu}?${txtrst}

#Check to make sure that the config file exists
if [ ! -e ~/.cdrrc ]
then
    #Create it if it doesn't
    echo
    echo -n "${bldred}"
    echo -n "No " 
    echo -n "${bldblu}"
    echo -n ~/.cdrrc 
    echo -n "${bldred}"
    echo " file detected" 
    echo -n "${bldgrn}"
    echo -n "Creating " 
    echo -n "${bldblu}"
    echo ~/.cdrrc
    echo -n $txtrst
    touch ~/.cdrrc
fi

if [ $# -eq 0 ]
then
    echo
    flag=0
    for i in `cat ~/.cdrrc`
    do
        if [ $flag -eq 0 ]
        then
            echo -n "${bldblu}"
            echo -n "$i: "
            flag=1
        else
            echo -n $txtrst
            echo $i
            flag=0
        fi
    done
    echo
else
    if [ $1 == \+ ] 
    then
        #The user wants this directory added to their .cdrrc
        echo adding $2

    else
        echo moving to $1
    fi
fi

echo -n $txtrst
