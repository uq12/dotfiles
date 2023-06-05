function dump
    set tn (date +%d%m%Y%H%M%S)
    set url $argv[1]
    # set n (mktemp lynx-dumps-XXXXXXXXXXXX$tn.txt)
    set n (echo $url|awk -F '/' '{print $NF}')
    echo $n.txt
    # lynx -dump -nolist $url > $n.txt
    lynx -dump -nolist $url | pandoc -f man -t plain -o $n.txt
    sleep 2
    # set n (mktemp $tn-w3m-dumps-XXXXXXXXXXXX.txt)
    # echo $n
    # w3m -dump $url > $n
    # for i in $tn*
      # cat $i > out.txt
  # end
end
