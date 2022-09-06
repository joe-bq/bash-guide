#!/bin/bash 

# run the command with
# command  git branch -v   | tr -s "[:blank:]" ' ' | head -n 1 | cut -d' '  -f2  | xargs ~/Downloads/clean_branch.sh
# 

USAGE="Usage: $0 branch1 branch2 branch3 ..."
if [ "$#" == "0" ]; then                 # If zero arguments were supplied,
  echo "Error: no branche names provided."
  echo "$USAGE"                          # display a help message
  exit 1                                 # and return an error.
fi


while (( "$#" )); do 
    if [ "$1" != "master" ]; then 
        echo cleaning $1
        printf "git branch -D $1\n";
        git branch -D $1;
        if [ "$?" == 0 ]; then
           printf "git push upstream :$1\n";
           git push upstream :$1
        else
           printf "failed to delete $1 locally"
        fi
    fi
    shift 
done

echo done.
exit 0