#!/usr/local/bin/bash

# this script shows you how to create 
#   1. indexed array
#   2. associative array

indexed_array[1]=0

# print all the arrays with ${indexed_array[@]}
printf 'the indexed_array = %s\n', ${indexed_array[@]}

declare -A associative_array=( [HDD]=Samsung [Monitor]=Dell [Keyboard]=A4Tech )
# printf all the elements 
printf 'the associative_array = %s\n', ${associative_array[@]}

# ${!associative_array[@]}
# do the loop
for key in "${!associative_array[@]}"; do echo ${key}; done

declare -A assArray1
assArray1[fruit]=Mango
assArray1[bird]=Cockatail
assArray1[flower]=Rose
assArray1[animal]=Tiger

for  key in "${!assArray1[@]}"; do echo ${key}; done