#!/bin/bash
# shows that shell parameter expansion 


string=01234567890abcdefgh
echo ${string:7}
# 7890abcdefgh
echo ${string:7:0}

echo ${string:7:2}
# 78
echo ${string:7:-2}
# 7890abcdef
echo ${string: -7}
# bcdefgh
echo ${string: -7:0}

echo ${string: -7:2}
#bc
echo ${string: -7:-2}
#bcdef
set -- 01234567890abcdefgh
#echo ${1:7}
7890abcdefgh
#echo ${1:7:0}

echo ${1:7:2}
#78
echo ${1:7:-2}
#7890abcdef
echo ${1: -7}
#bcdefgh
echo ${1: -7:0}

echo ${1: -7:2}
#bc
echo ${1: -7:-2}
#bcdef
array[0]=01234567890abcdefgh
echo ${array[0]:7}
#7890abcdefgh
echo ${array[0]:7:0}

echo ${array[0]:7:2}
#78
echo ${array[0]:7:-2}
#7890abcdef
echo ${array[0]: -7}
#bcdefgh
echo ${array[0]: -7:0}

echo ${array[0]: -7:2}
#bc
echo ${array[0]: -7:-2}
#bcdef
