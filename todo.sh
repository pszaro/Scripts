#!/bin/bash

# Updated target to DropBox so db can comes across machines
TARGET=~/Desktop/Dropbox/.todo

if [ -d $1 ] && [ $# -gt 0 ]
  then
    TARGET=$1/.todo
    shift
fi

touch $TARGET

if [ $# -eq 0 ]
  then
    echo ; nl $TARGET ; echo
fi

if [ "$1" = "add" ]
  then
    shift
    echo "$*" >> $TARGET
    echo ; nl $TARGET ; echo
fi

if [ "$1" = "remove" ] || [ "$1" = "done" ]
  then
    sed -i.bak -e "$2d" $TARGET
    rm $TARGET.bak
    echo ; nl $TARGET ; echo
fi

if [ "$1" = "clear" ]
  then
    echo "" > $TARGET
    sed -i.bak -e "1d" $TARGET
    rm $TARGET.bak
    echo ; nl $TARGET ; echo
fi

if [ "$1" = "search" ]
  then
    grep -IFnr --directories=recurse "TODO" * | grep -v "todo.sh"| uniq >> $TARGET
    cat $TARGET | sort -u > $TARGET.bak
    mv $TARGET.bak $TARGET
    echo ; nl $TARGET ; echo
fi
