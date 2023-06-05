function pi --wraps='pip install --use-pep517'  --description 'alias pi pip install --upgrade --use-pep517'
  .venv/bin/pip install --upgrade --use-pep517 $argv; 
end
