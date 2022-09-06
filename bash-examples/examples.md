-- examples 
https://www.computerhope.com/unix/bash/shift.htm


如何使用shift



-- 关于 $'\0'的使用 

参考： https://www.gnu.org/software/bash/manual/bash.html#Major-Differences-From-The-Bourne-Shell
   The $'…' quoting syntax, which expands ANSI-C backslash-escaped characters in the text between the single quotes, is supported (see ANSI-C Quoting).

https://stackoverflow.com/questions/36587660/in-a-bash-script-what-would-0-evaluate-to-and-why


To complement rici's helpful answer:

Note that this answer is about bash. ksh and zsh also support $'...' strings, but their behavior differs:
* zsh does create and preserve NUL (null bytes) with $'\0'.
* ksh, by contrast, has the same limitations as bash, and additionally interprets the first NUL in a command substitution's output as the string terminator (cuts off at the first NUL, whereas bash strips such NULs).

$'\0' is an ANSI C-quoted string that technically creates a NUL (0x0 byte), but effectively results in the empty (null) string (same as ''), because any NUL is interpreted as the (C-style) string terminator by Bash in the context of arguments and here-docs/here-strings.

As such, it is somewhat misleading to use $'\0' because it suggests that you can create a NUL this way, when you actually cannot:

You cannot create NULs as part of a command argument or here-doc / here-string, and you cannot store NULs in a variable:

echo $'a\0b' | cat -v # -> 'a' - string terminated after 'a'
cat -v <<<$'a\0b' # -> 'a' - ditto
In the context of command substitutions, by contrast, NULs are stripped:

echo "$(printf 'a\0b')" | cat -v # -> 'ab' - NUL is stripped
However, you can pass NUL bytes via files and pipes.

printf 'a\0b' | cat -v # -> 'a^@b' - NUL is preserved, via stdout and pipe
Note that it is printf that is generating the NUL via its single-quoted argument whose escape sequences printf then interprets and writes to stdout. By contrast, if you used printf $'a\0b', bash would again interpret the NUL as the string terminator up front and pass only 'a' to printf.
If we examine the sample code, whose intent is to read the entire input at once, across lines (I've therefore changed line to content):

while read -r -d $'\0' content; do  # same as: `while read -r -d '' ...`
    echo "${content}"
done <<< "${some_variable}"
This will never enter the while loop body, because stdin input is provided by a here-string, which, as explained, cannot contain NULs.
Note that read actually does look for NULs with -d $'\0', even though $'\0' is effectively ''. In other words: read by convention interprets the empty (null) string to mean NUL as -d's option-argument, because NUL itself cannot be specified for technical reasons.

In the absence of an actual NUL in the input, read's exit code indicates failure, so the loop is never entered.

However, even in the absence of the delimiter, the value is read, so to make this code work with a here-string or here-doc, it must be modified as follows:

while read -r -d $'\0' content || [[ -n $content ]]; do
    echo "${content}"
done <<< "${some_variable}"
However, as @rici notes in a comment, with a single (multi-line) input string, there is no need to use while at all:

read -r -d $'\0' content <<< "${some_variable}"
This reads the entire content of $some_variable, while trimming leading and trailing whitespace (which is what read does with $IFS at its default value, $' \t\n').
@rici also points out that if such trimming weren't desired, a simple content=$some_variable would do.

Contrast this with input that actually contains NULs, in which case while is needed to process each NUL-separated token (but without the || [[ -n $<var> ]] clause); find -print0 outputs filenames separated by a NUL each):

while IFS= read -r -d $'\0' file; do
    echo "${file}"
done < <(find . -print0)
Note the use of IFS= read ... to suppress trimming of leading and trailing whitespace, which is undesired in this case, because input filenames must be preserved as-is.
