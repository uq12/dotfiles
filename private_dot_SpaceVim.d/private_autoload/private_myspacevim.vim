function! myspacevim#before() abort
    " let g:neomake_c_enabled_makers = ['clang']
    " you can defined mappings in bootstrap function
    " for example, use kj to exit insert mode.
    inoremap jj <Esc>
    

    nnoremap <silent> mt :Translate<CR>
    vnoremap <silent> mt :TranslateVisual<CR>
    vnoremap <silent> mr :TranslateReplace<CR>

    let g:translate#default_languages = {
          \ 'en': 'ru',
          \ 'ru': 'en'
        \ }

    let g:neoformat_python_black = {
    \ 'exe': 'black',
    \ 'stdin': 1,
    \ 'args': ['-q', '-'],
    \ }
    let g:neoformat_enabled_python = ['black']

    autocmd BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path "%"

    let g:CheatSheetDisableFrameworkDetection=0

    " Команда Vim, используемая для открытия нового буфера
    let g:CheatSheetReaderCmd='new'

    " Тип файла шпаргалки
    let g:CheatSheetFt='markdown'

    " Программа, используемая для получения шпаргалки с ее аргументами
    " let g:CheatSheetUrlGetter='curl --silent'

    " Отметьте, чтобы добавить файл cookie в запрос
    " let g:CheatSheetUrlGetterIdFlag='-b'

    " базовый URL шпаргалки
    " let g:CheatSheetBaseUrl='https://cht.sh'

    " Настройки шпаргалки не включают ни настройки стиля, ни комментарии,
    " см. другие варианты ниже
    " let g:CheatSheetUrlSettings='q'

    " шпаргалка пейджер
    " let g:CheatPager='less -R'

    " тема pygmentize, используемая для вывода пейджера, см. :CheatPager :styles-demo
    " let g:CheatSheetPagerStyle=rrt

    " Показывать комментарии в ответах по умолчанию
    " (установка этого значения на 0 означает передачу ?Q серверу)
    " let g:CheatSheetShowCommentsByDefault=1

    " Оставаться в исходном буфере (установите значение 0, чтобы сохранить фокус на буфере шпаргалки)
    " let g:CheatSheetStayInOrigBuf=1

    " имя буфера шпаргалки
    " let g:CheatSheetBufferName="_cheat"

    " Выбор по умолчанию в обычном режиме (строка за всей строкой, слово за словом под курсором)
    " let g:CheatSheetDefaultSelection="line"
    let g:neoformat_try_formatprg = 1

    " Включить выравнивание
    let g:neoformat_basic_format_align = 1

    " Включить преобразование табуляции в пробелы
    let g:neoformat_basic_format_retab = 1

    " Включить обрезку завершающих пробелов
    let g:neoformat_basic_format_trim = 1

    let g:neoformat_run_all_formatters = 1

    let g:vimwiki_list = [{'path': '~/my_site/', 'path_html': '~/public_html/'},
            \ {'path': '/sdcard/GitJournal/', 'ext': '.md'}]

    " let g:startify_list_order = [
      " \ ['Мои последние использованные файлы в текущем каталоге:'],
      " \ 'dir',
      " \ ['   My most recently used files:'],
      " \ 'files',
      " \ ['   These are my sessions:'],
      " \ 'sessions',
      " \ ['   These are my bookmarks:'],
      " \ 'bookmarks',
      " \ ]
      "other configs
    let g:github_dashboard = { 'username': 'easy-zzz', 'password': $GITHUB_TOKEN }
    let g:gista#client#default_username = 'easy-zzz'
    " neovim on Linux
    " autocmd BufNewFile,BufRead /dev/shm/gopass* setlocal noswapfile nobackup noundofile shada=""
    " neovim on MacOS
    " autocmd BufNewFile,BufRead /private/**/gopass** setlocal noswapfile nobackup noundofile shada=""
    " vim on Linux
    autocmd BufNewFile,BufRead /dev/shm/gopass* setlocal noswapfile nobackup noundofile viminfo=""
    " vim on MacOS
    " autocmd BufNewFile,BufRead /private/**/gopass** setlocal noswapfile nobackup noundofile viminfo=""
    "
      " autocmd bufnewfile *.c so ~/.SpaceVim.d/templates/c_header.txt
      " autocmd bufnewfile *.c exe "1," . 10 . "g/File Name :.*/s//File Name : " .expand("%")
      " autocmd bufnewfile *.c exe "1," . 10 . "g/Creation Date :.*/s//Creation Date : " .strftime("%d-%m-%Y")
      " autocmd Bufwritepre,filewritepre *.c execute "normal ma"
      " autocmd Bufwritepre,filewritepre *.c exe "1," . 10 . "g/Last Modified :.*/s/Last Modified :.*/Last Modified : " .strftime("%c")
      " autocmd bufwritepost,filewritepost *.c execute "normal `a"
      "
  " some configuration above ...

    " let mapleader=" "


    let g:syntastic_javascript_checkers = [ 'jshint' ]
    let g:syntastic_ocaml_checkers = ['merlin']
    let g:syntastic_python_checkers = ['pylint']
    let g:syntastic_shell_checkers = ['shellcheck']

" some configuration below ...
endfunction

function! myspacevim#after() abort
    " you can remove key binding in bootstrap_after function
    " iunmap kj
    " call clipboard#set('tmux load-buffer -', 'tmux save-buffer -')
    " let g:startify_list_order = [
      " \ ['Мои последние использованные файлы в текущем каталоге:'],
      " \ 'dir',
      " \ ['   My most recently used files:'],
      " \ 'files',
      " \ ['   These are my sessions:'],
      " \ 'sessions',
      " \ ['   These are my bookmarks:'],
      " \ 'bookmarks',
      " \ ]
      autocmd bufnewfile *.c so ~/.SpaceVim.d/templates/c_header.txt
      autocmd bufnewfile *.c exe "1," . 10 . "g/File Name :.*/s//File Name : " .expand("%")
      autocmd bufnewfile *.c exe "1," . 10 . "g/Creation Date :.*/s//Creation Date : " .strftime("%d-%m-%Y")
      autocmd Bufwritepre,filewritepre *.c execute "normal ma"
      autocmd Bufwritepre,filewritepre *.c exe "1," . 10 . "g/Last Modified :.*/s/Last Modified :.*/Last Modified : " .strftime("%c")
      autocmd bufwritepost,filewritepost *.c execute "normal `a"


    call clipboard#set('termux-clipboard-set', 'termux-clipboard-get')
    hi Comment guifg=#5C6370 ctermfg=59
endfunction
