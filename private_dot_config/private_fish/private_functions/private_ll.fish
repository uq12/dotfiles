function ll --wraps='exa -l --color=always --group-directories-first --no-permissions --octal-permissions --icons' --description 'alias ll=exa -l --color=always --group-directories-first --no-permissions --octal-permissions --icons'
  exa -l --color=always --group-directories-first --no-permissions --octal-permissions --icons $argv; 
end
