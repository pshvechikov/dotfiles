
set nocompatible              " be iMproved, required
filetype off                  " required


if &diff
    " no options at all for vimdiff
else
    "=====================================================
    " Vundle settings
    "=====================================================
    " set the runtime path to include Vundle and initialize
    "
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    Plugin 'gmarik/Vundle.vim'      " let Vundle manage Vundle, required


    "---------=== Code/project navigation ===-------------
    Plugin 'scrooloose/nerdtree'            " Project and file navigation
    Plugin 'scrooloose/nerdcommenter'       " Smart code commenter
    Plugin 'majutsushi/tagbar'              " Class/module browser (tags in memory)
    " Plugin 'xolox/vim-easytags'           " If needed to store tags in files


    "------------------=== Other ===----------------------
    Plugin 'tpope/vim-surround'             " Parentheses, brackets, quotes, XML tags, and more
    Plugin 'Raimondi/delimitMate'           " Intelligent autocomplete
    Plugin 'kien/ctrlp.vim'                 " Convenient navigation
    " think about following plugins -- too slow and eating 100cpu
    " Plugin 'Shougo/unite.vim'               " Convenient navigation
    " Plugin 'Shougo/vimproc.vim'             " for unite async mode
    Plugin 'vim-scripts/diffchanges.vim'    " difchanges in file
    Plugin 'itchyny/lightline.vim'          " Minimal statusline
    Plugin 'godlygeek/tabular'              " Tabularize envirnoment

    "--------------=== Snippets support ===---------------
    Plugin 'SirVer/ultisnips'               " Track the engine.
    Plugin 'honza/vim-snippets'             " snippets repo


    ""--------------=== Completion ===---------------
    Plugin 'Valloric/YouCompleteMe'         " completion
    Plugin 'ervandew/supertab'              " man c-n to tab for compatibility YCM with UltiSnips

    ""------------------=== Latex ===---------------------
    Plugin 'lervag/vim-latex'               " latex module


    ""------------------=== Colors ===---------------------
    Plugin 'altercation/vim-colors-solarized'   " solarized colors


    "---------------=== Languages support ===-------------
    " --- Python ---
    Plugin 'klen/python-mode'                " Python mode (docs, refactor, lints, highlighting, run and ipdb and more)
    Plugin 'funorpain/vim-cpplint'           " google cppline static checker, that is run by pressing F7
    " Plugin 'mitsuhiko/vim-jinja'           " Jinja support for vim
    " Plugin 'mitsuhiko/vim-python-combined' " Combined Python 2/3 for Vim

    Plugin 'vim-scripts/Vim-R-plugin'        " R language  in vim

     call vundle#end()                      " required


    "====================================================
    " YouCompleteMe and UltiSnip fix settings
    "=====================================================

    " show completion even in comments
    let g:ycm_complete_in_comments = 1
    let g:ycm_collect_identifiers_from_comments_and_strings = 1
    let g:ycm_collect_identifiers_from_tags_files = 1

    " set omnifunc=syntaxcomplete#Complete
    " let g:ycm_filetype_blacklist = {
    "     \ 'tex' : 1,
    "     \ 'plaintex' : 1,
    " 	\ }
    " add language keywords to list of autocomplete
    let g:ycm_seed_identifiers_with_syntax = 1
    " if one want to use ctags he should assure oneself that
    " >> ctags --version print Exuberant Ctags, see :help YouCompleteMe
    "

    " make YCM compatible with UltiSnips (using supertab)
    let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
    " let g:ycm_server_use_vim_stdout = 1
    " let g:ycm_server_log_level = 'debug'
    " let g:ycm_server_keep_logfiles = 1




    " hack to workaround with YCM
    let g:SuperTabDefaultCompletionType = '<C-n>'
    " hack to allow delimitMate use shift-tab to exit one level
    " of comments
    let g:SuperTabMappingBackward = '<c-p>'

    let g:UltiSnipsExpandTrigger = "<tab>"
    let g:UltiSnipsJumpForwardTrigger = "<tab>"
    " let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

    " where all snippets are stored
    let g:UltiSnipsSnippetsDir = "~/.vim/bundle/vim-snippets/UltiSnips"
    let g:ultisnips_python_style = "google"

    "====================================================
    " DelimitMate
    "=====================================================
    " for python dosstrings
    au FileType python let b:delimitMate_nesting_quotes = ['"']
    " Use this option to tell delimitMate which characters should be considered
    " matching pairs. Read |delimitMateAutoClose| for details.
    let delimitMate_matchpairs = "(:),[:],{:}"
    " dirty hack against langmap which destroys square brackets
    set langmap=[[,]]


    "====================================================
    " NERDTree and NERDCommenter
    "=====================================================
    " show NERDTree on F1 pressed
    map <F1> :NERDTreeToggle<CR>
    " ignore theese extensions
    let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$']
    " to add space after commmant symbol
    let NERDSpaceDelims=1

    "====================================================
    " Tagbar
    "=====================================================

    " sort always by position in file, not by name
    let g:tagbar_sort = 0

    "====================================================
    " Lightline
    "=====================================================

    let g:lightline = {
        \ 'colorscheme': 'solarized_dark'
        \ }

    "=====================================================
    " Unite,  see
    " http://www.codeography.com/2013/06/17/replacing-all-the-things-with-unite-vim.html
    "=====================================================
    " " auto insert mode
    " let g:unite_enable_start_insert = 1
    " " unite is places in the bottom
    " let g:unite_split_rule = "botright"
    " " act like CtrlP
    " " nnoremap <C-p> :Unite file_rec/async:!<cr>

    " " Unite
    " let g:unite_source_history_yank_enable = 1

    " " call unite#filters#matcher_default#use(['matcher_fuzzy'])

    " nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
    " nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
    " nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
    " nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
    " nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
    " nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>

    " " Custom mappings for the unite buffer
    " autocmd FileType unite call s:unite_settings()

    " function! s:unite_settings()
    " " Play nice with supertab
    " let b:SuperTabDisabled=1
    " " Enable navigation with control-j and control-k in insert mode
    " imap <buffer> <C-j>   <Plug>(unite_select_next_line)
    " imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
    " endfunction

    " nnoremap <leader>ft :Unite file_rec/async:! -default-action=tabopen<cr>
    " nnoremap <leader>fs :Unite file_rec/async:! -default-action=split<cr>
    " nnoremap <leader>fv :Unite file_rec/async:! -default-action=vsplit<cr>
    " nnoremap <leader>fc :Unite file_rec/async:!<cr>

    "====================================================
    " Latex settings
    "=====================================================

    " Enable latex
    let g:latex_enabled = 1
    " complete closing brace on label editing
    " let g:latex_complete_close_braces = 1
    " jump to the first error on quickfix window is open
    let g:latex_quickfix_autojump = 0
    " ignore any warnings
    let g:latex_quickfix_ignore_all_warnings = 1
    " which warnings should be ignored
    let g:latex_quickfix_ignored_warnings = [ ]
      " \ 'Underfull',
      " \ 'Overfull',
      " \ 'specifier changed to',
      " \ ]
    "  callback
    let g:latex_latexmk_callback = 1
    " set viewer and configure forward search with <leader>ls combination
    let g:latex_view_general_viewer = 'open -a Skim'
    let g:latex_view_general_viewer = '/Applications/Skim.app/Contents/MacOS/Skim'

    " set switching to Russian keyboard by pressing C-^
    " the combination is awful but it is default and we will use it
    " set keymap=russian-jcukenmac
    " " the option for being able to press CTRL-N or CTRL-P to complete from
    " set iminsert=0
    " set imsearch=0
    " highlight lCursor guifg=NONE guibg=Cyan


    augroup langmap_tex
       autocmd!
       autocmd FileType tex set langmap=йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ъ],фa,ыs,вd,аf,пg,рh,оj,лk,дl,э'
       autocmd FileType tex set langmap+=яz,чx,сc,мv,иb,тn,ьm,ю.,ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х{,Ъ},ФA,ЫS
       autocmd FileType tex set langmap+=ВD,АF,ПG,РH,ОJ,ЛK,ДL,ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Ж:,Б<,Ю>,]`,[~
       autocmd FileType tex set langmap+=ВD,АF,ПG,РH,ОJ,ЛK,ДL,ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Ж:,Б<,Ю>,]`,[~
       autocmd FileType tex set langmap+=\\,^
       autocmd FileType tex " Please see https://github.com/SirVer/ultisnips/issues/418
       autocmd FileType tex " set langmap+=\\;*
       autocmd FileType tex set spell
    augroup END


    "====================================================
    " General settings
    "=====================================================

    " do not close files when type :e filename
    " set hidden
    filetype on
    filetype plugin on
    filetype plugin indent on

    set backspace=indent,eol,start
    " aunmenu Help.
    " aunmenu Window.
    let no_buffers_menu=1
    set mousemodel=popup

    set ruler
    set completeopt-=preview
    set gcr=a:blinkon0
    set ttyfast


    syntax on
    if has("gui_running")
        " GUI? SET THEME AND WINDOW SIZE
        set background=dark
        set lines=40 columns=125
        let g:solarized_termcolors=256
        colorscheme solarized

        if has("mac")
            set guifont=Consolas:h16
            set fuoptions=maxvert,maxhorz
        else
            set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 15
        endif
        else
            set t_Co=16
            set background=dark
            colorscheme solarized
    endif
    set switchbuf=useopen

    " make  line with cursor  to be highlighted
    set cursorline

    set enc=utf-8        " utf-8 по дефолту в файлах
    set ls=2             " всегда показываем статусбар
    set incsearch        " инкреминтируемый поиск
    set hlsearch         " подсветка результатов поиска
    set number           " показывать номера строк
    set relativenumber   " относительная нумерация строк
    " autocmd InsertEnter * :set number
    " autocmd InsertLeave * :set relativenumber
    set scrolloff=5      " 5 строк при скролле за раз

    " for purposes of copying text from terminal
    nnoremap <F2> :set nonumber! \| set norelativenumber! <CR>

    nnoremap <F3> :mksession! ~/vim_session <cr> " Quick write session with F3
    nnoremap <F4> :source ~/vim_session <cr>     " And load session with F4
    set ssop-=options    " do not store global and local values in a session
    set ssop-=folds      " do not store folds
    set sessionoptions+=buffers " do store unsaved buffer content


    " set autochdir     " change directory to edited file
    set ignorecase
    set smartcase     " case searching tunning

    " hide panels
    set guioptions-=m   " меню
    set guioptions-=T    " тулбар
    set guioptions-=r   "  скроллбары

    " tab tunning
    set tabstop=2
    set shiftwidth=2
    set expandtab
    set showmatch     " set show matching parenthesis
    set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
    set autoindent    " always set autoindenting on
    set copyindent    " copy the previous indentation on autoindenting

    set history=1000         " remember more commands and search history
    set undolevels=1000      " use many levels of undo
    set wildignore=*.swp,*.bak,*.pyc,*.class
    set title                " change the terminal's title
    set visualbell           " don't beep
    set noerrorbells         " don't beep

    set autoread             " auto refresh unchanged files if they are
                             " modified on disk

    " set split methods
    set splitbelow
    set splitright

    "----------=========  Folding ==========------------

    " remap keys zj an zk to jump to next closed fold
    nnoremap <silent> <leader>zj :call NextClosedFold('j')<cr>
    nnoremap <silent> <leader>zk :call NextClosedFold('k')<cr>
    function! NextClosedFold(dir)
       let cmd = 'norm!z' . a:dir
       let view = winsaveview()
       let [l0, l, open] = [0, view.lnum, 1]
       while l != l0 && open
          exe cmd
          let [l0, l] = [l, line('.')]
          let open = foldclosed(l) < 0
       endwhile
       if open
          call winrestview(view)
       endif
    endfunction

    " FOLDING SETTINGS
    " set foldmethod=indent   "fold based on indent
    " set foldnestmax=10      "deepest fold is 10 levels
    " set nofoldenable        "dont fold by default
    " set foldlevel=1         "this is just what i use

    " toggle fold with space rather then inconvenient za
    nnoremap <space> za
    " fix colour of fold
    hi Folded ctermbg=Black ctermfg=6 cterm=bold



    "----------=========  MISC ==========------------

    " command to make diff with saved version of edited file
    if !exists(":DiffOrig")
       command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                   \ | wincmd p | diffthis
    endif

    " disable colorcolumn that is set up nowhere ??
    " highlight ColorColumn ctermbg=0

    " Once again define highlighting trailing whitespaces because autocmds are
    " not working when opening files in split mode
    highlight WhitespaceEOL  cterm=bold ctermfg=6 ctermbg=0 guibg=#073642
    match WhitespaceEOL /\s\+$/
    " delete all spaces at the end of lines
    autocmd BufWritePre * :%s/\s\+$//e

    set colorcolumn=80
    highlight ColorColumn cterm=bold ctermfg=6 ctermbg=0 guibg=#073642

    " highlight text on dark when exceeding 80 column
    augroup vimrc_autocmds
       autocmd!
       autocmd FileType ruby,python,javascript,c,cpp highlight Excess ctermbg=0 guibg=Black
       autocmd FileType ruby,python,javascript,c,cpp match Excess /\%80v.*/
       autocmd FileType ruby,python,javascript,c,cpp highlight WhitespaceEOL  cterm=bold ctermfg=6 ctermbg=0 guibg=#073642
       autocmd FileType ruby,python,javascript,c,cpp match WhitespaceEOL /\s\+$/
       autocmd FileType ruby,python,javascript,c,cpp set nowrap
       autocmd FileType cpp set tabstop=2
       autocmd FileType cpp set shiftwidth=2
    augroup END


    set spelllang=ru_ru,en_us
    " get suggestions on spelling
    set complete+=kspell

    " <Ctrl-l> redraws the screen and removes any search highlighting.
    nnoremap <silent> <C-c> :nohl<CR><C-c>
    " wrap long lines to the new lines
    set wrap
    " do not break words in the middle
    set linebreak

    "====================================================
    " Here would be useful comments on how vim executes,
    " behaves, some useful features, links, etc.
    "=====================================================
    "
    " 1. To see where all keymaps appears to be on the FS:
    "    :echo globpath(&rtp, "keymap/*.vim")
    " 2. See all mappings: :help index
    "
    "

    " FIXME: https://github.com/klen/python-mode/issues/525
    let g:pymode_rope = 0
    let g:pymode_folding = 0

endif
