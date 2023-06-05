#!/data/data/com.termux/files/usr/bin/fish
#=============================================================================
# basic.fish --- basic script files     
# Copyright (c) 2016-2021 nvspc EasyQuest
# Author: Ivan Yastrebov < easy-quest@mail.ru >
# URL: https://easyquest.host
#=============================================================================
# -*-  mode:fish; tab-width:4  -*-
set -gx EDITOR vim
set -gx GH_TOKEN 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

termux-change-repo

pkg up -y


if test -d ~/.SpaceVim
  echo ~/.SpaceVim exists
else
  echo ~/.SpaceVim no exists
  curl -sLf https://spacevim.org/install.sh | bash -s -- --install vim
end
#


if test -d ~/.config/omf
  echo ~/.config/omf exists
else
  echo ~/.config/omf no exists
  curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
end

sleep 3
# omf help

