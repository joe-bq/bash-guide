#!/bin/bash 

# run the command with
# command  git branch -v   | tr -s "[:blank:]" ' ' | head -n 1 | cut -d' '  -f2  | xargs ~/Downloads/clean_branch.sh
# 
echo cleaning $1

if [ "$1" != "master" ]; then 
    printf "git branch -D $1\n";
    git branch -D $1;
    printf "return result = $?\n"
    if [ "$?" == 0 ]; then
       printf "git push upstream :$1\n";
       git push upstream :$1
    else
       printf "failed to delete $1 locally"
    fi
fi

