#!/bin/bash

# do arithmetics with `let' and print
n=20
let n+=2
printf \%i\\n $n


# declare a integer variables and do arithmetics
declare -i a
a=2
a+=2
printf %u\\n $a
