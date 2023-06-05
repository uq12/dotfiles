#!/usr/bin/env fish
#
function venv
    python -m venv .venv $argv
    .venv/bin/python -m pip install -U pip setuptools wheel pip-tools yapf autoflake isort coverage pylint rich bpython requests --use-pep517
    printf "#!/usr/bin/env bash \nsource .venv/bin/activate" >.envrc
    direnv allow
    curl https://www.toptal.com/developers/gitignore/api/python >.gitignore
    # mkdir ./core; touch ./core/__init__.py
    # printf "#!/usr/bin/env python \n# -*- coding: utf-8 -*-\n\nfrom rich import print\nimport requests" > ./core/core.py
    # printf "#!/usr/bin/env python \n# -*- coding: utf-8 -*-\n\nfrom core.core import *\n\nprint(dir())" > ./main.py
    # clear; .venv/bin/python ./main.py
end
