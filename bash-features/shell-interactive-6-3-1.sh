#/bin/bash 

# 判断一个shell 是否是interactive

# run this command with 
#  1. bash -i shell-interactive-6-3-1.sh
#  2. bash -c ". shell-interactive-6-3-1.sh"
# you can get different result 


case "$-" in
*i*)	echo This shell is interactive ;;
*)	echo This shell is not interactive ;;
esac


if [ -z "$PS1" ]; then
    echo This shell is not interactive
else 
    echo This shell is interactive
fi 