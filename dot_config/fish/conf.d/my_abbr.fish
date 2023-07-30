abbr -a --set-cursor=! -- yi 'yay -S --noconfirm !'
abbr -a -- rm 'rm -Rf'
abbr -a -- xx 'chmod +x'
abbr -a -- f 'chezmoi edit ~/.config/fish/config.fish'
abbr -a -- fcd 'cd ~/.config/fish/;ls'
abbr -a -- gs lazygit
abbr -a -- z chezmoi
abbr -a -- za 'chezmoi add'
abbr -a -- zcd 'chezmoi cd'
abbr -a -- zl 'chezmoi list -x scripts,dirs'
abbr -a -- ze 'chezmoi edit'
abbr -a -- zd 'chezmoi diff'
abbr -a --set-cursor=! -- trans trans\ :ru\ -b\ \'!\'
abbr -a --set-cursor=! -- t trans\ :ru\ -b\ \'!\'
abbr -a -- yc 'yadm commit -m "'
abbr -a -- yl 'yadm list -a'
abbr -a -- ya 'yadm add'
abbr -a -- y yadm
abbr -a --position anywhere -- i install
abbr -a --position anywhere -- bp bpython
abbr -a -- py python
abbr -a --set-cursor=! -- goo google\ --lang=ru\ --stop=10\ \'!\'
abbr -a -- pt 'ptpython --vi --dark-bg'

# tutor
abbr -a --position anywhere --function last_history_item -- !!
abbr -a --regex .+\\.txt --function vim_edit -- vim_edit_texts
