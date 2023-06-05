if not set -q GH_BASE_DIR
    set GH_BASE_DIR $HOME/Projects/repos
end

function __gcl_remote_cache_clear --argument user
    set -e GH_REPOS_CACHE_$user
end

function __gcl_remote_repos --argument user
    type -q jq; or return -1
    set -l repos_url https://api.github.com/users/$user/repos
    curl -s $repos_url | jq -r '.[] | "\(.name)"'
end

function __gcl_remote_repos_cached --argument user
    set -l cache_path GH_REPOS_CACHE_$user
    if not set -q $cache_path
        set -g $cache_path (__gcl_remote_repos $user)
    end
    string join \n $$cache_path
end

function __gcl_local_repos --argument user
    set -l path $GH_BASE_DIR/github.com/$user
    test -d $path; and command ls -L $path
end

function __gcl_user_completion
    command ls -L $GH_BASE_DIR/github.com
end

function __gcl_repo_completion
    set -l cmd (commandline -o)
    set -l user $cmd[2]
    set -l repos (__gcl_local_repos $user) (__gcl_remote_repos_cached $user)
    string join \n $repos | sort | uniq -du
end

complete -c gcl -n '__fish_is_token_n 2' --arguments '(__gcl_user_completion)' --no-files
complete -c gcl -n '__fish_is_token_n 3' --arguments '(__gcl_repo_completion)' --no-files
