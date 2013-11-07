filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

Bundle 'altercation/vim-colors-solarized'
Bundle 'jc00ke/nerdcommenter'
Bundle 'jc00ke/taglist.vim'
Bundle 'shawncplus/phpcomplete.vim'
Bundle 'tomtom/checksyntax_vim'
Bundle 'mileszs/ack.vim'
Bundle 'vim-scripts/camelcasemotion'
Bundle 'Townk/vim-autoclose'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'snipMate'

set background=dark

" only show class and methods in the taglist
let tlist_php_settings = 'php;c:Class;f:Methods'

" only show tags in the curret file
let Tlist_Show_One_File = 1

" hide folds in tlist
let Tlist_Enable_Fold_Column = 0

" focus window when toggled
let Tlist_GainFocus_On_ToggleOpen = 1

" close window when tag is selected
let Tlist_GainFocus_On_ToggleOpen = 1

" map comma to be the leader key
let mapleader=","

" map leager g to :tag <tag>
noremap <C-g> <c-]>

" map W to w
cmap W w

" tell vim to keep a backup file
set backup

" tell vim where to put its backup files
set backupdir=/private/tmp

" tell vim where to put swap files
set dir=/private/tmp

" read in all plugins using pathogen
"call pathogen#runtime_append_all_bundles()
" generate help tags for all plugins read in by pathogen
"call pathogen#helptags()

" map leader e,v to .vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
" reload .vimrc when it changes
autocmd! bufwritepost vimrc source ~/.vimrc

" set CommandT max height
let g:CommandTMaxHeight = 15

" auto reload files when they change
set autoread

" we don't need to be compatible with VI
set nocompatible

" prevent security exploits
set modelines=0

" set default encoding to utf-8
set encoding=utf-8
" show a list of commands currently entered
set showcmd
" always show at least 3 lines above and below the current line being edited
set scrolloff=3
" hide empty buffers
set hidden
" show tab completions for the command line
set wildmenu
" limit which tab completions are shown
set wildmode=list:longest
" use visualbell rather than beeping
set visualbell
" show the cursorline
set cursorline
" improve window drawing
set ttyfast
" show the current position
set ruler
" always show the status line
set laststatus=2

" show line numbers relative to the current line
if has("relativenumber")
    set relativenumber
endif

" tell vim where to put undo files
if has("undodir")
    set undodir=/private/tmp
endif

" use a persistent undo file to allow undo even if the file has been closed
if has("undofile")
    set undofile
endif

" make sure F1 does not toggle help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" show line width columns
if has("colorcolumn")
	set colorcolumn=80
endif

" make the number gutter wider
set numberwidth=3

" fix VIMs broken regex
nnoremap / /\v
vnoremap / /\v
" ignore case
set ignorecase
" don't ignore case if explicitly typing caps
set smartcase
" turn on incremental search
set incsearch
" show matches as you type
set showmatch
" hilight matches
set hlsearch
" map space + leader to clear search results
nnoremap <leader><space> :noh<cr>

" replace all hits by default (not just the first one in a line) when doing
" searcn n' replace
set gdefault

" remap b, e, w to be camel case aware
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

" use tabs to jump to mathing bracket
" nnoremap <tab> %
" vnoremap <tab> %

" Map up/down/left/right to nothing
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>

" move by file line rather than screen line
nnoremap j gj
nnoremap k gk

" map keys to move around splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" map leader-a to Ack
nnoremap <leader>a :Ack

" map leader-w to open a new split window
nnoremap <leader>w <C-w>v<C-w>l

" map leader-t to open tag list
nnoremap <leader>t :TlistToggle <cr>
" map leader-o to open command-t
nnoremap <leader>o :FufFile<cr>

" enable syntax highlighting
syntax on

" set the colorscheme
colors solarized

filetype plugin indent on

" use tabs, not spaces
set noexpandtab
" tabstops of 4
set tabstop=4
" indents of 4
set shiftwidth=4
" turn on auto/smart indenting
set autoindent smartindent
" make <tab> and <backspace> smart
set smarttab
" allow backspacing over indent, eol & start
set backspace=eol,start,indent

" highlight variables in SQL strings and do SQL-syntax highlighting
autocmd FileType php let php_sql_query=1

" highlight html inside of php strings
autocmd FileType php let php_htmlInStrings=1

" set auto-highlighting of matching brackets for php only
autocmd FileType php DoMatchParen

" check *.ctp files for HTML syntax errors when written
" autocmd BufWritePost *.ctp CheckSyntax html

" check *.ctp files for PHP syntax errors when written
autocmd BufWritePost *.ctp CheckSyntax php

" autocomplete funcs and identifiers for languages
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

" autoclose the omnicomplete scratch preview buffer when cursor moves
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
" autoclose the omnicomplete scratch preview buffer when leaving insert mode
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

set cot+=menuone

" strip trailing whitespace on save
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" this is a bit dangerous. It will strip whitespace from binary files too.
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
