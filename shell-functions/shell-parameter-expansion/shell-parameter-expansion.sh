#/bin/bash

${parameter:-word}
If parameter is unset or null, the expansion of word is substituted. Otherwise, the value of parameter is substituted.

${parameter:=word}
If parameter is unset or null, the expansion of word is assigned to parameter. The value of parameter is then substituted. Positional parameters and special parameters may not be assigned to in this way.

${parameter:?word}
If parameter is null or unset, the expansion of word (or a message to that effect if word is not present) is written to the standard error and the shell, if it is not interactive, exits. Otherwise, the value of parameter is substituted.

${parameter:+word}
If parameter is null or unset, nothing is substituted, otherwise the expansion of word is substituted.

${parameter:offset}
${parameter:offset:length}

This is referred to as Substring Expansion. It expands to up to length characters of the value of parameter starting at the character specified by offset. If parameter is ‘@’, an indexed array subscripted by ‘@’ or ‘*’, or an associative array name, the results differ as described below. If length is omitted, it expands to the substring of the value of parameter starting at the character specified by offset and extending to the end of the value. length and offset are arithmetic expressions (see Shell Arithmetic).
...
Here are some examples illustrating substring expansion on parameters and subscripted arrays:

If parameter is an indexed array name subscripted by ‘@’ or ‘*’, the result is the length members of the array beginning with ${parameter[offset]}


${!prefix*}
${!prefix@}
Expands to the names of variables whose names begin with prefix, separated by the first character of the IFS special variable. When ‘@’ is used and the expansion appears within double quotes, each variable name expands to a separate word.

${!name[@]}
${!name[*]}
If name is an array variable, expands to the list of array indices (keys) assigned in name. If name is not an array, expands to 0 if name is set and null otherwise. When ‘@’ is used and the expansion appears within double quotes, each key expands to a separate word.

${#parameter}
The length in characters of the expanded value of parameter is substituted. If parameter is ‘*’ or ‘@’, the value substituted is the number of positional parameters. If parameter is an array name subscripted by ‘*’ or ‘@’, the value substituted is the number of elements in the array. If parameter is an indexed array name subscripted by a negative number, that number is interpreted as relative to one greater than the maximum index of parameter, so negative indices count back from the end of the array, and an index of -1 references the last element.

${parameter#word}
${parameter##word}
match and delete at beginning --

The word is expanded to produce a pattern and matched according to the rules described below (see Pattern Matching). If the pattern matches the beginning of the expanded value of parameter, then the result of the expansion is the expanded value of parameter with the shortest matching pattern (the ‘#’ case) or the longest matching pattern (the ‘##’ case) deleted. If parameter is ‘@’ or ‘*’, the pattern removal operation is applied to each positional parameter in turn, and the expansion is the resultant list. If parameter is an array variable subscripted with ‘@’ or ‘*’, the pattern removal operation is applied to each member of the array in turn, and the expansion is the resultant list.

${parameter%word}
${parameter%%word}
match and delete at end --

The word is expanded to produce a pattern and matched according to the rules described below (see Pattern Matching). If the pattern matches a trailing portion of the expanded value of parameter, then the result of the expansion is the value of parameter with the shortest matching pattern (the ‘%’ case) or the longest matching pattern (the ‘%%’ case) deleted. If parameter is ‘@’ or ‘*’, the pattern removal operation is applied to each positional parameter in turn, and the expansion is the resultant list. If parameter is an array variable subscripted with ‘@’ or ‘*’, the pattern removal operation is applied to each member of the array in turn, and the expansion is the resultant list.

${parameter/pattern/string}
match and repalce --

The pattern is expanded to produce a pattern just as in filename expansion. Parameter is expanded and the longest match of pattern against its value is replaced with string. The match is performed according to the rules described below (see Pattern Matching). If pattern begins with ‘/’, all matches of pattern are replaced with string. Normally only the first match is replaced. If pattern begins with ‘#’, it must match at the beginning of the expanded value of parameter. If pattern begins with ‘%’, it must match at the end of the expanded value of parameter. If string is null, matches of pattern are deleted and the / following pattern may be omitted. If the nocasematch shell option (see the description of shopt in The Shopt Builtin) is enabled, the match is performed without regard to the case of alphabetic characters. If parameter is ‘@’ or ‘*’, the substitution operation is applied to each positional parameter in turn, and the expansion is the resultant list. If parameter is an array variable subscripted with ‘@’ or ‘*’, the substitution operation is applied to each member of the array in turn, and the expansion is the resultant list.

${parameter^pattern}
${parameter^^pattern}
${parameter,pattern}
${parameter,,pattern}
match and convert case --
This expansion modifies the case of alphabetic characters in parameter. The pattern is expanded to produce a pattern just as in filename expansion. Each character in the expanded value of parameter is tested against pattern, and, if it matches the pattern, its case is converted. The pattern should not attempt to match more than one character. The ‘^’ operator converts lowercase letters matching pattern to uppercase; the ‘,’ operator converts matching uppercase letters to lowercase. The ‘^^’ and ‘,,’ expansions convert each matched character in the expanded value; the ‘^’ and ‘,’ expansions match and convert only the first character in the expanded value. If pattern is omitted, it is treated like a ‘?’, which matches every character. If parameter is ‘@’ or ‘*’, the case modification operation is applied to each positional parameter in turn, and the expansion is the resultant list. If parameter is an array variable subscripted with ‘@’ or ‘*’, the case modification operation is applied to each member of the array in turn, and the expansion is the resultant list.

${parameter@operator}
parameter conversion such as upper-case, lower-case, quoted content, Escaped contents...

The expansion is either a transformation of the value of parameter or information about parameter itself, depending on the value of operator. Each operator is a single letter:

    U
    The expansion is a string that is the value of parameter with lowercase alphabetic characters converted to uppercase.

    u
    The expansion is a string that is the value of parameter with the first character converted to uppercase, if it is alphabetic.

    L
    The expansion is a string that is the value of parameter with uppercase alphabetic characters converted to lowercase.

    Q
    The expansion is a string that is the value of parameter quoted in a format that can be reused as input.

    E
    The expansion is a string that is the value of parameter with backslash escape sequences expanded as with the $'…' quoting mechanism.

    P
    The expansion is a string that is the result of expanding the value of parameter as if it were a prompt string (see Controlling the Prompt).

    A
    The expansion is a string in the form of an assignment statement or declare command that, if evaluated, will recreate parameter with its attributes and value.

    K
    Produces a possibly-quoted version of the value of parameter, except that it prints the values of indexed and associative arrays as a sequence of quoted key-value pairs (see Arrays).

    a
    The expansion is a string consisting of flag values representing parameter’s attributes.

    If parameter is ‘@’ or ‘*’, the operation is applied to each positional parameter in turn, and the expansion is the resultant list. If parameter is an array variable subscripted with ‘@’ or ‘*’, the operation is applied to each member of the array in turn, and the expansion is the resultant list.

    The result of the expansion is subject to word splitting and filename expansion as described below.