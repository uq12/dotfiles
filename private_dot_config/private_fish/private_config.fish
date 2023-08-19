# Применить .profile: используйте это, чтобы поместить совместимый с рыбой материал .profile в
if test -f ~/.fish_profile
    source ~/.fish_profile
end

# Добавляем ~/.local/bin в PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

status --is-interactive; and source (jump shell fish | psub)
# jump shell fish | source

yq shell-completion fish | source

complete -c cheat.sh -xa '(curl -s cheat.sh/:list)'

mcfly init fish | source

direnv hook fish | source

abbr -a -- foo bar
abbr -a -- rm 'rm -Rf'
abbr -a -- xx 'chmod +x'
abbr -a -- f 'chezmoi edit ~/.config/fish/config.fish'
abbr -a -- fcd 'cd ~/.config/fish/;ls'
abbr -a -- gs lazygit
abbr -a -- fix termux-fix-shebang
abbr -a -- xclip termux-clipboard-set
abbr -a -- ou termux-open-url
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
abbr -a -- gco 'git checkout'
abbr -a --set-cursor=! -- 4DIRS for\ dir\ in\ \*/\ncd\ \$dir\n!\ncd\ ..\nend
abbr -a --position anywhere -- i install
abbr -a --position anywhere -- bp bpython
abbr -a -- py python
abbr -a --set-cursor=! -- goo google\ --lang=ru\ --stop=10\ \'!\'
abbr -a --set-cursor=! -- gr grep\ --recursive\ --line-number\ --binary-files=without-match\ \'!\'
abbr -a -- pt 'ptpython --vi --dark-bg'
abbr -a --set-cursor=! -- sms termux-sms-send\ -n\ +79628611711\ \'!\'


source (/data/data/com.termux/files/usr/bin/starship init fish --print-full-init | psub)
