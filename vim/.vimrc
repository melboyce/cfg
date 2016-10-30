" vimrc

set nocompatible


" plugins
call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'scrooloose/syntastic'
Plug 'saltstack/salt-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

call plug#end()


" start-up and candy
filetype plugin indent on
set background=dark
set t_Co=256
colorscheme lomokai
syntax on


" tabbing
set tabstop=4     " the number of columns a tab is
set expandtab     " use spaces instead of tabs
set shiftwidth=4  " number of columns used by <</>> (re-indent)


" various settings
set autoindent              " use current line's indent level for next line
set autoread                " auto-read changed file
set backspace=indent,eol,start  " backspace is more aggro
set clipboard=unnamed       " don't use the system clipboard for all operations
set confirm                 " ask before discarding changes
set cursorline              " add highlight for line cursor is on
set encoding=utf-8          " this should be default
set fileformat=unix         " unix line endings
set hidden                  " hides current buffer if modified and new file is opened
set hlsearch                " highlights all matches
set ignorecase              " ignores case on searches
set incsearch               " highlight searches in real-time
set laststatus=2            " always show status line
set listchars=trail:·,tab:»·
set matchtime=2             " tenths of a second to show matching brackets
set nofoldenable            " don't fold on open
set noicon                  " x-window icon... heh...
set nowrap                  " don't wrap long lines
set number                  " line numbers in the gutter
set pastetoggle=<f11>       " toggle paste mode with F11
set report=0                " always report line changes
set scrolloff=5             " min. lines to keep visible above and below the cursor
set shell=/bin/zsh          " which shell to use for shell commands
set shiftround              " calculate proper tab width when re-indenting
set showcmd                 " show partial command in last status line
set showmatch               " show matching bracket if possible (see: matchtime)
set sidescroll=1            " minimal number of columns to scroll left or right (req. nowrap)
set sidescrolloff=5         " minimal number of columns to keep on screen for left/right scrolling
set smartcase               " disables 'ignorecase' if the search pattern contains cased glyphs
set smartindent             " take an educated C-style guess at appropriate indenting
set smarttab                " amoung other things, ensure <BS> at the start of a line erases 'tabstop' chars.
set title                   " sets the window title (format: titlestring)
set ttyfast                 " modernizes the manner in which vim handles writing to the terminal
set viminfo='50,<1000       " save 50 marks and 1000 lines of register contents
set wildignore=*.o,*~,*pyc  " ignore these file patterns when completing file and dir names
set wildmenu                " adds a menu to <TAB> completions in command mode
set wildmode=longest,list   " first <TAB> completes until longest string, second <TAB> provides a list


" directories, backups, undo...
silent !mkdir -p ~/.vim-backup
silent !mkdir -p ~/.vim-undo
set bdir=~/.vim-backup
set noswapfile
set backup
set backupskip=/tmp/*,$TMP/*
set undodir=~/.vim-undo
set undofile
set undolevels=50


" file types
autocmd filetype HTML       setlocal ts=2 sts=2 sw=2 et
autocmd filetype javascript setlocal ts=2 sts=2 sw=2 et
autocmd bufread,bufnewfile /etc/nginx/*   set ft=nginx
autocmd bufread,bufnewfile /etc/haproxy/* set ft=haproxy


" keymaps
" arrow-keys
noremap <left> <nop>
noremap <down> <nop>
noremap <up> <nop>
noremap <right> <nop>
inoremap <left> <nop>
inoremap <down> <nop>
inoremap <up> <nop>
inoremap <right> <nop>

" empty command line clears search
:noremap <cr> :nohlsearch<cr>

" buffers
nnoremap <f2> :ls<cr>:b
nnoremap <f7> :bprev<cr>
nnoremap <f8> :bnext<cr>

" stop using escape - it's too far away
inoremap jk <esc>


" lightline
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'component': {
    \     'readonly': '%{&readonly?"⭤":""}',
    \ },
    \ 'separator': { 'left': "⮀", 'right': "⮂" },
    \ 'subseparator': { 'left': "|", 'right': "|" }
    \ }


" syntastic
" TODO these are basic settings; review the docs and clean this shit up
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_flake8_args = '--ignore="E501"'
let g:syntastic_warning_symbol = '▷'
let g:syntastic_error_symbol = '▶'


" misc
set t_ti= t_te=  " http://www.shallowsky.com/linux/noaltscreen.html


" autocmds
" auto-save on leaving insert mode or changing text in normal mode
" XXX find a way to disable this for uwsgi applications
" autocmd InsertLeave,TextChanged * if expand('%') != '' | update | endif

" restore cursor position
augroup vimrcEx
    autocmd!
    autocmd bufreadpost * if line("'\'") > 0 && line("'\'") <= line("$") | exe "normal g`\"" | endif
augroup END
