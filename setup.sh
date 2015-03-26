#!/bin/bash

#The purpose of this script is to install this implimentation of cdr.
#cdr is a command line tool that is a logical extension of cd. It adds
#a way of easily bookmarking file locations and moving between them with ease.

. ~/.libs/colours

function setup {
   
    bldylw
    echo "    Inserting alias into bashrc"
    echo "alias cdr='. `pwd`/cdr.sh'" >> ~/.bashrc
    echo "    Installing tab completion into bashrc"
    echo ". `pwd`/cdr_completion.sh" >> ~/.bashrc
    bldgrn
    echo "    Done"
    bldylw
    echo "    Inserting adaptation to shell prompt into bashrc"
    echo "PS1='`cat prompt.config`'" >> ~/.bashrc
    bldgrn
    echo "    Done"

    #after everything else, this is probably the last step.
    bldylw
    echo "    Updating installation status"
    echo 0 > ./installation_status
    bldgrn
    echo "    Done"
    bldgrn
    echo "Installation Successful"
}


bldylw
echo -n "Installing "
bldblu
cat ./program_name
if [[ -e ./installation_status ]]
then
    if [[ `cat ./installation_status` == "0" ]]
    then
        bldylw
        echo "    Program aready installed"
        bldgrn
        echo "Installation Successful"
    else
        setup
    fi
else
    setup
fi
txtrst

