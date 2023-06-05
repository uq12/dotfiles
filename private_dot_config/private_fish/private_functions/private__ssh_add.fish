function _ssh_add --description 'create new ssh key'
    if ! test -f ~/.ssh/id_ed25519.pub
        ssh-keygen -t ed25519 -C "easy.quest@ya.ru"
    end
end
