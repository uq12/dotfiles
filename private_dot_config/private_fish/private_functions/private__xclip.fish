function _xclip
#termux-clipboard-get 
  # termux-clipboard-get | trans :ru -b
  # set text (termux-clipboard-get | trans :ru -b -no-ansi);printf $text
  # echo $text | termux-tts-speak
  # termux-clipboard-get
  trans :ru -b -j (termux-clipboard-get)
end
