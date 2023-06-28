[dl-logo-ic]
[ ]
Android Concurrency CLI CS Database DI Frontend Hardware IntelliJ Kotlin Linux 
MP Misc Node Productivity React-Native React Rust Server State-Management 
Stories Testing TypeScript TUI Web Nazmul Idris About Us Authors

fish shell scripting manual

Jan 19, 2021 ∙ Nazmul Idris

  • Hi, I'm Nazmul, a software engineer, entrepreneur, designer, leader,
    HsingI-er, racer, healer, storyteller. I leadership, authenticity,
    empowerment, lifelong learning, , , & , 😃.

Subscribe for updates

 

 

 

 

[fish-shell]

  • Shebang line at the top of your scripts
  • How to set variables
      □ Variable scopes: local, global, global-export
      □ Lists
      □ Storing return values from running a command
      □ Ranges
  • How to write for loops
  • How to write if statements
      □ Commonly used conditions
      □ Program, script, or function exit code
      □ Difference between set -q and test -z
      □ Multiple conditions with operators: and, or
      □ Another common operator: not
      □ References
  • How to split strings by a delimiter
  • How to perform string comparisons
  • How to write switch statements for strings
  • How to execute strings
  • How to write functions
      □ Pass arguments to a function
      □ Return values from a function
  • How to handle file and folder paths for dependencies
  • How to write multi line strings to files
  • How to create colorized echo output
  • How to get user input
  • How to use sed
  • How to use xargs
  • How to use cut to split strings
  • How to calculate how long the script took to run

Научитесь писать скрипты для fish на примере.

## Строка Shebang в верхней части ваших скриптов ##

Чтобы иметь возможность запускать скрипты fish с вашего терминала, вам нужно сделать две вещи.

 1. Добавьте следующую строку shebang в начало файла сценария.: #!/usr/bin/
    env fish.
 2. Пометьте файл как исполняемый с помощью следующей команды: chmod +x
    <YOUR_FISH_SCRIPT_FILENAME>.

## Как установить переменные ##

Имейте в виду, что все типы значений, которые могут быть присвоены переменным в
fish являются строками. Не существует таких вещей, как логическое значение,
целое число, число с плавающей запятой и т. д. Вот простой пример
присвоения значения переменной. 

set MY_VAR "some value"

Одна из самых полезных вещей, которые вы можете сделать, это сохранить вывод
команды в переменную.  который вы запускаете в оболочке. Это полезно, когда вы
тестируете посмотрите, вернула ли какая-то программа или команда некоторые
значения, которые означают, что вы должны выполнить какую-либо другую команду
(используя сравнение строк, операторы if и switch заявления). Вот
примеры того, как это сделать.

set CONFIG_FILE_DIFF_OUTPUT (diff ~/Downloads/config.fish ~/.config/fish/config.fish)
set GIT_STATUS_OUTPUT (git status --porcelain)

## Области действия переменных: локальная, глобальная, глобальная экспортная ##

There are times when you have to export variables to child processes and also
times when you have to export variables to global scope. There are also times
when you want this variable to be limited to local scope of the function you
are writing. The fish documentation on the set function has more information on
this.

  • To limit variables to local scope of the function (even if there is a
    global variable of the same name) use set -l. This type of variable is not
    available to the entire fish shell. An example of this is a local variable
    that is used to hold some value just for the scope of a function, such as
    set -l fname (realpath .)
  • Export variable using set -x (this is only available inside the current
    fish shell). An example of this is setting the DISPLAY environment variable
    for X11 session in a fish function that is running in a crontab headless
    environment.
  • Export variable globally using set -gx (this is available to any programs
    in your OS, not just the currently running fish shell process). An example
    of this is setting the JAVA_HOME environment variable for all programs
    running on the machine.

## Списки ##

Вот пример добавления значений к переменной. По умолчанию переменные fish
являются списками.

set MY_VAR $MY_VAR "another value"

Вот как вы можете создавать списки.

set MY_LIST "value1" "value2" "value3"

## Сохранение возвращаемых значений при выполнении команды ##

Вот пример сохранения значения, возвращаемого при выполнении команды, в
переменную.

set OUR_VAR (math 1+2)
set OUR_VAR (date +%s)
set OUR_VAR (math $OUR_VAR / 60)

Поскольку все переменные fish являются списками, вы можете получить доступ к
отдельным элементам, используя [n] оператор, где n=1 для первого элемента (не 0
индекс). Вот пример.  А отрицательные числа обращаются к элементам с конца.

set LIST one two three
echo $LIST[1]  # one
echo $LIST[2]  # two
echo $LIST[3]  # three
echo $LIST[-1] # Это тот же элемент, что и выше

## Диапазоны ##

Вы также можете использовать диапазоны из переменной/списка, продолжая пример выше.

set LIST one two three
echo $LIST[1..2]  # one two
echo $LIST[2..3]  # two three
echo $LIST[-1..2] # three two


## Как писать циклы ##

Поскольку переменные по умолчанию содержат списки, их очень легко перебирать.
Вот пример.

set FOLDERS bin
set FOLDERS $FOLDERS .atom
set FOLDERS $FOLDERS "my foldername"
for FOLDER in $FOLDERS
  echo "item: $FOLDER"
end

Вы также можете упростить приведенный выше код, поместив все команды set в одну
строку, как здесь.

set FOLDERS bin .atom "my foldername"
for FOLDER in $FOLDERS
  echo "item: $FOLDER"
end

Вы также можете поместить весь оператор for в одну строку, как здесь.

set FOLDERS bin .atom "my foldername"
for FOLDER in $FOLDERS ; echo "item: $FOLDER" ; end

## Как писать операторы if ##

Ключом к написанию операторов if является использование команды test для оценки
некоторого выражения до логического значения. Это может быть сравнение строк
или даже проверка существования файлов и папок. Вот некоторые примеры. Вы также
можете использовать оператор not для префикса теста для проверки обратного
условия.

Commonly used conditions #

Checking the size of an array. $argv contains the list of arguments passed to a
script from the command line.

if test (count $argv) -lt 2
  echo "Usage: my-script <arg1> <arg2>"
  echo "Eg: <arg1> can be 'foo', <arg2> can be 'bar'"
else
  echo "👋 Do something with $arg1 $arg2"
end

String comparison in variable.

if test $hostname = "mymachine"
  echo "hostname is mymachine"
end

Checking for file existence.

if test -e "somefile"
  echo "somefile exists"
end

Checking for folder existence.

if test -d "somefolder"
  echo "somefolder exists"
end

Checking for file wildcard existence is a little different than both file and
folder checks. The reason for this is how fish handles wildcards - they are
expanded by fish before it performs whatever command on them.

set -l files ~/Downloads/*.mp4 # This wildcard expression is expanded to include the actual files
if test (count $files) -gt 0
  mv ~/Downloads/*.mp4 ~/Videos/
  echo "📹 Moved '$files' to ~/Videos/"
else
  echo "⛔ No mp4 files found in Downloads"
end

Here’s an example of how to use the not operator in the previous example.

if not test -d "somefolder"
  echo "somefolder does not exist"
end

Program, script, or function exit code #

The idea with exit codes is that your function or entire fish script could be
used by some other program that understands exit codes. In other words there
could be an if statement that is going to use the exit code to determine some
condition. This is a very common pattern that is used with other command line
programs. Exit codes are different than return values from a function.

Here’s an example of using the exit code of some git command:

if (git pull -f --rebase)
  echo "git pull with rebase worked without any issues"
else
  echo "Something went wrong that requires manual intervention, like a merge conflict"
end

Here’s an example of how to test whether a command executed without errors.

if sudo umount /media/user/mountpoint
  echo "Successfully unmounted /media/user/mountpoint"
end

You can also check the value of the $status variable. Fish stores the return
value in this variable, just after a command is executed. Here’s more info on
this.

When you are writing functions you can use the following keyword to exit
functions or loops: return. This may be followed by a number. So here’s what it
means.

 1. return or return 0 - This means that the function exited normally.
 2. return 1 or some other number > 0 - This means that the function had some
    problem.

You can exit the fish shell itself using exit. And the integer exit codes have
the same meaning as above.

Difference between set -q and test -z #

There is a subtle difference between using set -q and test -z in if statements
when checking to see if a variable is empty.

 1. In the case of test -z make sure to wrap the variable in quotes, since it
    might just break in some edge cases if it isn’t wrapped in quotes.
 2. However, you can use set -q to test if a variable has been set without
    wrapping it in quotes.

Here’s an example.

set GIT_STATUS (git status --porcelain)
if set -q $GIT_STATUS ; echo "No changes in repo" ; end
if test -z "$GIT_STATUS" ; echo "No changes in repo" ; end

Multiple conditions with operators: and, or #

If you want to combine multiple conditions into a single statement, then you
can use or and and operators. Also if you want to check the inverse of a
condition, you can use !. Here’s an example of a function that checks for 2
arguments to be passed via the command line. Here’s the logic we will describe.

 1. If both the arguments are missing, then usage information should be
    displayed to the CLI, and perform an early return.
 2. If either one of the arguments is missing, then display a prompt stating
    that one of the arguments is missing, and perform an early return.

function requires-two-arguments
  # No arguments are passed.
  if set -q "$argv"
    echo "Usage: requires-two-arguments arg1 arg2"
    return 1
  end
  # Only 1 argument is passed.
  if test -z "$argv[1]"; or test -z "$argv[2]"
    echo "arg1 or arg2 can not be empty"
    return 1
  end
  echo "Thank you, got 1) $argv[1] and 2) $argv[2]"
end

Here are some notes on the code.

 1. What does the set -q $variable function do? It returns true if $variable is
    empty.
 2. Instead of set -q, if you wanted to use test function in order to determine
    if a variable is empty, you can use:
      □ if test -z "$variable".
      □ if test ! -n "$variable" or if not test -n "$variable".
 3. If you wanted to replace the or check above w/ test, this is what it would
    look like if test -z "$argv[1]"; or test -z "$argv[2]".
 4. When you use or, and operators that you have to terminate the condition
    expression w/ a ;.
 5. Make sure to wrap the variable in empty quotes. If an empty string is
    contained inside the variable, then without these quotes, the statements
    will cause errors.

Here’s another example of this to test if $variable is empty or not.

if test -z "$variable" ; echo "empty" ; else ; echo "non-empty" ; end

Here’s another example of this to test if $variable contains a string or not.

if test -n "$variable" ; echo "non-empty" ; else ; echo "empty" ; end

Another common operator: not #

Here’s an example of using the not operator to test whether a string contains a
string fragment or not.

if not string match -q "*md" $argv[1]
  echo "The argument passed does not end in md"
else
  echo "The argument passed ends in md"
end

References #

 1. test command
 2. set command
 3. if command
 4. stackoverflow answer: how to check if fish variable is empty
 5. stackoverflow answer: how to put multiple conditions in fish if statement

How to split strings by a delimiter #

There are situations when you want to take the output of a command, which is a
string, and then split it by some delimiter, to use just a portion of the
output string. An example of getting the SHA checksum of a given file. The
command shasum <filename> produces something like df..d8 <filename>. Let’s say
that we just wanted the first portion of this string (the SHA), knowing that
the delimiter is two space characters, we can do the following to get just the
checksum portion and store it in $CHECKSUM. Here’s more info on the string
split command.

set CHECKSUM_ARRAY_STRING (shasum $FILENAME)
set CHECKSUM_ARRAY (string split "  " $SOURCE_CHECKSUM_ARRAY)
set CHECKSUM $CHECKSUM_ARRAY[1]

How to perform string comparisons #

In order to test substring matches in strings you can use the string match
command. Here is more information on the command:

 1. Official docs on string match.
 2. Stackoverflow answer on how to use it.

Here’s an example of this in action. Note the use of -q or --quiet which does
not echo the output of the string if the match condition was met (succeeded).

if string match -q "*myname*" $hostname
  echo "$hostname contains myname"
else
  echo "$hostname does not contain myname"
end

Here’s an example of checking for an exact string match.

if test $hostname = "machine-name"
  echo "Exact match"
else
  echo "Not exact match"
end

Here’s an example of testing whether a string is empty or not.

if set -q $my_variable
  echo "my_variable is empty"
end

Here’s a sophisticated example that tests to see if the packages ruby-dev and
ruby-bundler are installed. If they are then jekyll gets run, and if not, then
these packages are installed.

# Return "true" if $packageName is installed, and "false" otherwise.
# Use it in an if statement like this:
#
# if string match -q "false" (isPackageInstalled my-package-name)
#   echo "my-package-name is not installed"
# else
#   echo "my-package-name is installed"
# end
function isPackageInstalled -a packageName
  set packageIsInstalled (dpkg -l "$packageName")
  if test -z "$packageIsInstalled"
    set packageIsInstalled false
  else
    set packageIsInstalled true
  end
  echo $packageIsInstalled
end

# More info to find if a package is installed: https://askubuntu.com/a/823630/872482
if test (uname) = "Linux"

  echo "🐒isPackageInstalled does-not-exist:" (isPackageInstalled does-not-exist)

  if string match -q "false" (isPackageInstalled ruby-dev) ;
    or string match -q "false" (isPackageInstalled ruby-bundler)
    # Install ruby
    echo "ruby-bundler or ruby-dev are not installed; installing now..."
    echo sudo apt install -y ruby-bundler ruby-dev
  else
    bundle install
    bundle update
    bundle exec jekyll serve
  end

end

How to write switch statements for strings #

In order to create switch statements for strings, the test command is used here
as well (just like it was for if statements). The case statements need to match
substrings, which can be expressed using a combination of wildcard chars and
the substring you want to match. Here’s an example.

switch $hostname
case "*substring1*"
  echo "Matches $hostname containing substring1"
case "*substring2*"
  echo "Matches $hostname containing substring2"
end

You can combine this w/ if statements as well, and end up w/ something like
this.

if test (uname) = "Darwin"
  echo "Machine is running macOS"
  switch $hostname
  case "*MacBook-Pro*"
    echo "hostname has MacBook-Pro in it"
  case "*MacBook-Air*"
    echo "hostname has MacBook-Air in it"
  end
else
  echo "Machine is not running macOS"
end

How to execute strings #

The safest way to execute strings that are generated in the script is to use
the following pattern.

echo "ls \
  -la" | sh

This not only makes it easier to debug, but also avoids strange errors when
doing multi-line breaks using \.

How to write functions #

A fish function is just a list of commands that may optionally take arguments.
These arguments are just passed in as a list (since all variables in fish are
lists).

Here’s an example.

function say_hi
  echo "Hi $argv"
end
say_hi
say_hi everbody!
say_hi you and you and you

Once you have written a function you can see what it is by using type, eg: type
say_hi will show you the function that you just created above.

  • Here’s the doc for functions

Pass arguments to a function #

In addition to using $argv to figure out what parameters were passed to a
function, you can provide a list of named parameters that a function expects.
Here is more information on this from the official docs.

Some key things to keep in mind:

 1. Parameter names can not have - characters in them, so use _ instead.
 2. Do not use the ( and ) to pass arguments to a function, simply pass the
    arguments in a single line w/ spaces.

Here’s an example.

function testFunction -a param1 param2
  echo "arg1 = $param1"
  echo "arg2 = $param2"
end
testFunction A B

Here’s another example that tests for the existence of a certain number of
arguments that are passed to a function.

# Note parameter names can't have dashes in them, only underscores.
function my-function -a extension search_term
  if test (count $argv) -lt 2
    echo "Usage: my-function <extension> <search_term>"
    echo "Eg: <extension> can be 'fish', <search_term> can be 'test'"
  else
    echo "✋ Do something with $extension $search_term"
  end
end

Return values from a function #

You might want to return a value from a function (typically just a string). You
can also return many strings delimited by new lines. Regardless, the mechanism
for doing this is the same. You simply have to use echo to dump the return
value(s) to stdout.

Here’s an example.

function getSHAForFilePath -a filepath
  set NULL_VALUE ""
  # No $filepath provided, or $filepath does not exist -> early return w/ $NULL_VALUE.
  if set -q $filepath; or not test -e $filepath
    echo $NULL_VALUE
    return 0
  else
    set SHASUM_ARRAY_STRING (shasum $filepath)
    set SHASUM_ARRAY (string split "  " $SHASUM_ARRAY_STRING)
    echo $SHASUM_ARRAY[1]
  end
end

function testTheFunction
  echo (getSHAForFilePath ~/local-backup-restore/does-not-exist.fish)
  echo (getSHAForFilePath)
  set mySha (getSHAForFilePath ~/local-backup-restore/test.fish)
  echo $mySha
end

testTheFunction

How to handle file and folder paths for dependencies #

As your scripts become more complex, you might need to handle loading multiple
scripts. In this case you can just pull other scripts in from your current
script by using source my-script.fish. However fish looks for this
my-script.fish file in the current directory, from which you started executing
the script. And this current directory might not match where you need to load
this dependency from. This can happen if your main script is on the $PATH but
the dependencies are not. In this case, you can do something like the following
in your main script.

set MY_FOLDER_PATH (dirname (status --current-filename))
source $MY_FOLDER_PATH/my-script.fish

So what this snippet actually does is get the folder in which the main script
is running, and stores it in MY_FOLDER_PATH and then it become possible for any
dependencies to be loaded using the source command. There is one limitation to
this approach, which is that the path stored in MY_FOLDER_PATH is relative to
the directory from which the main script is actually executed. This is a subtle
detail that you may not care about, unless you need to have absolute path
names. In this case you can do the following.

set MY_FOLDER_PATH (realpath (dirname (status --current-filename)))
source $MY_FOLDER_PATH/my-script.fish

Using realpath gives you the fully qualified path name for your folder for the
uses cases where you need this capability.

How to write multi line strings to files #

There are many situations where you need to write strings and multi line
strings to new or existing files in your scripts.

Here’s an example of writing single strings to a file.

# echo "echo 'ClientAliveInterval 60' >> recurring-tasks.log" | xargs -I% sudo sh -c %
set linesToAdd "TCPKeepAlive yes" "ClientAliveInterval 60" "ClientAliveCountMax 120"
for line in $linesToAdd
  set command "echo '$line' >> /etc/ssh/sshd_config"
  executeString "$command | xargs -I% sudo sh -c %"
end

Here’s an example of writing multi line strings to a file.

# More info on writing multiline strings: https://stackoverflow.com/a/35628657/2085356
function _workflowWriteEmptyMarkdownContentToFile --argument datestr filename
  echo > $filename "\
---
Title: About $filename
Date: $datestr
---
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Your heading
"
end

How to create colorized echo output #

The set_color function allows fish to colorize and format text content that is
printed to stdout using echo. This is great when creating text output that
needs to have different foreground, background colors, and bold, italic, or
underlined output. There are many ways to use this command, and here are two
examples of how to use it (inline of echo statements, and just by itself).

function myFunction
  if test (count $argv) -lt 2
    set -l currentFunctionName (status function)
    echo "Usage: "(set_color -o -u)"$currentFunctionName"(set_color normal)\
      (set_color blue)" <arg1> "\
      (set_color yellow)"<arg2>"(set_color normal)
    set_color blue
    echo "- <arg1>: Something about arg1."
    set_color yellow
    echo "- <arg2>: Something about arg2"
    set_color normal
    return 1
  end
end

Notes:

 1. set_color normal has to be called to reset whatever formatting options were
    set in previous statements.
 2. set_color -u does underline, and set_color -o does bold.

How to get user input #

There are situations where you need to ask a user for confirmation before
performing some potentially destructive operation or you might need user input
for some argument to a function (that isn’t passed via the command line). In
these cases it is possible to get user input from the user by reading stdin
using the read function.

The following function simply returns a 0 for “Y”/”y”, and 1 for “N”/”n”.

# More info on prompting a user for confirmation using fish read function: https://stackoverflow.com/a/16673745/2085356
# More info about fish `read` function: https://fishshell.com/docs/current/cmds/read.html
function _promptUserForConfirmation -a message
  if not test -z "$message"
    echo (set_color brmagenta)"🤔 $message?"
  end

  while true
    # read -l -P '🔴 Do you want to continue? [y/N] ' confirm
    read -l -p "set_color brcyan; echo '🔴 Do you want to continue? [y/N] ' ; set_color normal; echo '> '" confirm
    switch $confirm
      case Y y
        return 0
      case '' N n
        return 1
    end
  end
end

And here is an example of using the _promptUserForConfirmation function.

if _promptUserForConfirmation "Delete branch $featureBranchName"
  git branch -D $featureBranchName
  echo "👍 Successfully deleted $featureBranchName"
else
  echo "⛔ Did not delete $featureBranchName"
end

How to use sed #

This is useful for removing fragments of files that are not needed, especially
when xargs is used to pipe the result of find.

Here’s an example that removes ./ from the start of each file that’s found.

echo "./.Android" | sed 's/.\///g'

Here’s a more complex example of using sed, find, and xargs together.

set folder .Android*
find ~ -maxdepth 1 -name $folder | sed 's/.\///g' | \
  xargs -I % echo "cleaned up name: %"

How to use xargs #

This is useful for piping the output of some commands as arguments for more
commands.

Here’s a simple example: ls | xargs echo "folders: ".

  • Which produces this: folders: idea-http-proxy-settings images tmp.
  • Note how the arguments are concatenated in the output.

Here’s a slightly different example using -I % which allows arguments to be
placed anywhere (not just at the end).

ls | xargs -I % echo "folder: %"

Which produces this output:

folder: idea-http-proxy-settings
folder: images
folder: tmp

Note how the arguments are each in a separate line.

How to use cut to split strings #

Let’s say you have a string "token1:token2" and you want to split the string
and only keep the first part of it. This can be done using the following cut
command.

echo "token1:token2" | cut -d ':' -f 1

  • -d ':' - this splits the string by the : delimiter
  • -f 1 - this keeps the first field in the tokenized string

Here’s a real example of finding all the HTML files in ~/github/
developerlife.com with the string "fonts.googleapis" in it and then opening
them up in subl.

cd ~/github/developerlife.com
echo \
"find . -name '*html' | \
 xargs grep fonts.googleapis | \
 cut -d ':' -f 1 | \
 xargs subl" \
 | sh

  • More info on the cut command

How to calculate how long the script took to run #

function timed -d Pass the program or function that you want to execute as an argument
  set START_TS (date +%s)

  # This is where your code would go.
  $argv

  sleep 5

  set END_TS (date +%s)
  set RUNTIME (math $END_TS - $START_TS)
  set RUNTIME (math $RUNTIME / 60)
  echo "⏲ Total runtime: $RUNTIME min ⏲"
end

#linux #misc

Related Posts

  • Mechanical keyboard review - Dygma Raise
  • Mechanical keyboard review - UHK v1, Mistel BAROCCO MD770, Drop Alt Captain
  • Linux (Ubuntu) desktop and laptop hardware review for software engineers
    (early 2021)
  • Customizing Ubuntu UI
  • Automatically updating copyright messages in JetBrains IDEs
  • Setting environment variables on macOS

 
Subscribe for updates Sponsored by R3BL
