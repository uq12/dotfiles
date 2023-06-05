function myhelp --argument myhelp
    set _URL 'https://cht.sh'
    # read -P 'Что ищем?: ' myhelp;
    set n (mktemp $myhelp-XXXXXXXXXXXX.txt)
    set url "$_URL/$myhelp?T"
    echo $url
    curl $url -o $n
    # curl cheat.sh/$argv
end
