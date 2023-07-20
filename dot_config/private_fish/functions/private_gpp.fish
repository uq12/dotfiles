function gpp --description 'git push'
    git add -A
    git commit -q -m "Update: $(date +%d.%m.%Y\ %H:%M:%S)"
    git push #-q
end
