function l. --wraps=exa\ -a\ \|\ grep\ -E\ \'^\\.\' --description alias\ l.=exa\ -a\ \|\ grep\ -E\ \'^\\.\'
  exa -a | grep -E '^\.' $argv; 
end
