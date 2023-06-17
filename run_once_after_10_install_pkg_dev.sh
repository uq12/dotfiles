#!/data/data/com.termux/files/usr/bin/bash
#=============================================================================
# basic.bash --- basic script files     
# Copyright (c) 2016-2021 nvspc EasyQuest
# Author: Ivan Yastrebov < easy-quest@mail.ru >
# URL: https://easyquest.host
#=============================================================================
export EDITOR="vim"
export GH_TOKEN="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"

pkg up -y
pkg i -y termux-api

termux-change-repo

pkg i -y which openssh git wget jump direnv yq jq fish exa \
  iproute2 mcfly bat w3m

pkg i -y build-essential cmake python vim gh x11-repo xorg-mkfontscale 

pkg i -y libgmp libmpc libmpfr libxml2 libxslt freetype libjpeg-turbo libpng \
  libsodium libzmq

pkg i -y jython units-cur python-pillow python-cryptography recoll-python \
   python-numpy  matplotlib opencv-python python-tkinter

chsh -s fish
#
# curl -L https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install | fish
# omf help


clear
curl -sLf https://spacevim.org/install.sh | bash -s -- -c
sleep 3
curl -sLf https://spacevim.org/install.sh | bash


