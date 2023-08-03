function fish_update_completions --description "Update man-page based completions"
# Не записывайте файлы .pyc, используйте manpath, очищайте старые завершения, отображайте прогресс.
    
    set -l update_args -B $__fish_data_dir/tools/create_manpage_completions.py --manpath --cleanup-in ~/.config/fish/generated_completions --progress $argv
    if set -l python (__fish_anypython)
        $python $update_args
    else
        printf "%s\n" (_ "python: исполняемый файл не найден") >&2
        return 1
    end
end
