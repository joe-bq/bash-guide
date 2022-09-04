#!/bin/bash

~
The value of $HOME

~/foo
$HOME/foo

~fred/foo
The subdirectory foo of the home directory of the user fred

~+/foo
$PWD/foo

~-/foo
${OLDPWD-'~-'}/foo

~N
The string that would be displayed by ‘dirs +N’

~+N
The string that would be displayed by ‘dirs +N’

~-N
The string that would be displayed by ‘dirs -N’
