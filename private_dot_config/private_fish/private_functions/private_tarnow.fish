function tarnow --wraps='tar -acf ' --wraps='tar -acf' --description 'alias tarnow tar -acf'
  tar -acf $argv; 
end
