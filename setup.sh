#!/bin/bash

#The purpose of this script is to install this implimentation of cdr.
#cdr is a command line tool that is a logical extension of cd. It adds
#a way of easily bookmarking file locations and moving between them with ease.

. ~/.libs/colours

echo "alias cdr='. `pwd`/cdr.sh'" >> ~/.bashrc
echo "PS1='`cat prompt.config`'" >> ~/.bashrc
