#!/bin/bash
# cdr.sh - Extension to cd that allows for bookmarking locations

. ~/.libs/colours


IFS='\
'

#Check to make sure that the config file exists
if [ ! -e ~/.cdrrc ]
then
    #Create it if it doesn't
    echo
    bldred
    echo -n "No " 
    bldblu
    echo -n ~/.cdrrc 
    bldred
    echo " file detected" 
    bldgrn
    echo -n "Creating " 
    bldblu
    echo ~/.cdrrc
    echo
    txtrst
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
                bldblu
                echo -n "$i: "
                flag=1
            else
                bldylw
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
            bldgrn
            echo -n "Adding " 
            bldblu
            echo $2
            txtrst
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
                    bldred
                    echo -n "Removing " 
                    bldblu
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
                bldred
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
                    bldylw
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
                bldred
                echo Location $1 not found.
            fi
        fi
    fi
fi

IFS=' '
txtrst
