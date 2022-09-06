#!/bin/bash

# file globbing not working for the !+ tiled expansion
if [ -a " ~+/bash-condition-expressions-6-4.sh" ]; then
    echo file  ~+/bash-condition-expressions-6-4.sh exists
fi


if [ -a "$PWD/bash-condition-expressions-6-4.sh" ]; then
    echo file ~+/bash-condition-expressions-6-4.sh exists
fi


if  [ -e "./bash-condition-expressions-6-4.sh" ]; then
    echo file ./bash-condition-expressions-6-4.sh exists
fi

if [ -a "$0" ]; then
    echo file "$0 do exists"
fi