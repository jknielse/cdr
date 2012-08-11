#!/bin/bash
# cdr.sh - Extension to cd that allows for bookmarking locations

# Text color variables
txtund=$(tput sgr 0 1)          # Underline
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) #  red
bldgrn=${txtbld}$(tput setaf 2) #  green
bldylw=${txtbld}$(tput setaf 3) #  yellow
bldblu=${txtbld}$(tput setaf 4) #  blue
bldwht=${txtbld}$(tput setaf 7) #  white
txtrst=$(tput sgr0)             # Reset
info=${bldwht}*${txtrst}        # Feedback
pass=${bldblu}*${txtrst}
warn=${bldred}*${txtrst}
ques=${bldblu}?${txtrst}


IFS='\
'

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
else
    if [ $# -eq 0 ]
    then
        echo
        echo Bookmarked Locations:
        flag=0
        for i in `cat ~/.cdrrc`
        do
            if [ $flag -eq 0 ]
            then
                echo -n "${bldblu}"
                echo -n "$i: "
                flag=1
            else
                echo -n "${bldylw}"
                echo $i
                flag=0
            fi
        done
        echo
    else
        if [ $1 == \+ ] 
        then
            #The user wants this directory added to their .cdrrc
            cdr - $2 >> /dev/null
            
            echo
            echo -n "${bldgrn}"
            echo -n "Adding " 
            echo -n "${bldblu}"
            echo $2
            echo -n $txtrst
            echo

            echo $2 >> ~/.cdrrc
            echo `pwd` >> ~/.cdrrc

        elif [ $1 == "-" ]
        then
            next=0
            found=0
            mod=0

            touch /tmp/cdrrcnew
            for i in `cat ~/.cdrrc`
            do
                if [ $next -eq 1 ]
                then
                    next=0
                    continue
                fi
                if [ $i == $2 ]
                then
                    echo
                    echo -n $bldred
                    echo -n "Removing " 
                    echo -n "${bldblu}"
                    echo $i
                    echo
                    found=1
                    next=1
                else
                    if [ $mod -eq 0 ]
                    then
                        mod=1
                        echo -n "$i " >> /tmp/cdrrcnew
                    else
                        mod=0
                        echo $i >> /tmp/cdrrcnew
                    fi
                fi
            done
            if [ $found -eq 0 ]
            then
                echo -n "${bldred}"
                echo Location $2 not found.
                rm /tmp/cdrrcnew
            else
                rm ~/.cdrrc
                mv /tmp/cdrrcnew ~/.cdrrc
            fi

        else
            cd ..
            next=0
            found=0
            for i in `cat ~/.cdrrc`
            do
                if [ $next -eq 1 ]
                then
                    echo -n "Moving to " 
                    echo -n "${bldylw}"
                    echo $i

                    cd $i
                    next=0
                fi
                if [ $i == $1 ]
                then
                    found=1
                    next=1
                fi
            done
            if [ $found -eq 0 ]
            then
                echo -n "${bldred}"
                echo Location $1 not found.
            fi
        fi
    fi
fi

IFS=' '
echo -n $txtrst
