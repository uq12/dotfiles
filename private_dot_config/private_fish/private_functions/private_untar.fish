function untar --wraps='tar -zxvf ' --wraps='tar -zxvf' --description 'alias untar tar -zxvf'
  tar -zxvf $argv; 
end
