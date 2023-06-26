# set fish_greeting
# function fish_prompt
    # fishline -s $status
# end
## Скрыть приветственное сообщение
# Set settings for https://github.com/franciscolourenco/done
# set -U __done_min_cmd_duration 10000
# set -U __done_notification_urgency_level low
# if status is-interactive
    # set FLINE_PATH $HOME/.config/fish/fishline
    # source $FLINE_PATH/init.fish
# end
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
    source ~/.fish_profile
end

## Исходный .profile для применения его значений
# bass source ~/.profile

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

status --is-interactive; and source (jump shell fish | psub)

yq shell-completion fish | source

complete -c cheat.sh -xa '(curl -s cheat.sh/:list)'

# set -U obsidian_path /sdcard/Documents/tldr
mcfly init fish | source

direnv hook fish | source

# bass eval $(okc-ssh-agent)

# function on_exit --on-event fish_exit
    # echo fish сейчас выходит
# end
source (/data/data/com.termux/files/usr/bin/starship init fish --print-full-init | psub)
##
abbr -a -- z chezmoi
abbr -a -- foo bar
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
