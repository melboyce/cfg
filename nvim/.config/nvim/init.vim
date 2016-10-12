" nvimrc
"
" mel@thestack.co


" plugins
call plug#begin('~/.config/nvim/autoload/plugged')

Plug 'benekastah/neomake'
Plug 'cespare/vim-toml'
Plug 'fatih/vim-go'
Plug 'itchyny/lightline.vim'
Plug 'saltstack/salt-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

call plug#end()


" candy
set background=dark
colorscheme lomokai


" settings
set cursorline         " highlight the current line
set confirm            " ask before discarding changes
set fileformat=unix    " line endings
set mouse=             " only savages use the mouse for editing. except for acme.
set ignorecase         " ignore case on searches
set matchtime=2        " tenths of a second to show matching brackets
set nofoldenable       " don't fold on open
set noicon             " x-windows icon
set nowrap             " no wrapping on long lines
set number             " line numbers in gutter
set pastetoggle=<F11>  " toggle paste mode with F11
set scrolloff=5        " min. lines to keep visible
set shiftround         " calculate proper tab width when re-indenting
set showcmd            " show partial command in last status line
set showmatch          " show matching bracket (see: matchtime)
set sidescroll=1       " min. number of columns to scroll (req: nowrap)
set sidescrolloff=5    " min. number of columns to keep visible
set smartcase          " disables 'ignorecase' if pattern contains cased chars
set smartindent        " takes an educated C-style guess for indenting
set title              " sets the x-windows title (format: titlestring)
set wildignore=*.o,*~,*pyc  " ignored globs in wildmenu
set wildmode=longest,list   " first <tab> is longest, second provides a list


" !!! neovim defaults
" autoindent
" autoread
" backspace=indent,eol,start
" complete doesn't include "i"
" display=lastline
" encoding=utf-8
" formatoptions=tcqj
" history=10000
" hlsearch
" incsearch
" langnoremap
" laststatus=2
" listchars=tab:> ,trail:-,nbsp:+
" mouse=a
" nocompatible
" nrformats=hex
" sessionoptions doesn't include "options"
" smarttab
" tabpagemax=50
" tags=./tags;,tags
" ttyfast
" viminfo includes "!"        
" wildmenu


" persistent undo
silent !mkdir -p ~/.local/share/nvim/undodir
set undodir=~/.local/share/nvim/undodir
set undofile


" filetype specifics
autocmd filetype HTML       setlocal ts=2 sts=2 sw=2 et
autocmd filetype go         setlocal ts=4 sts=4 sw=4 noet
autocmd filetype javascript setlocal ts=2 sts=2 sw=2 et
autocmd filetype python     setlocal ts=4 sts=4 sw=4 et
autocmd filetype yaml       setlocal ts=2 sts=2 sw=2 et
autocmd bufread,bufnewfile /etc/nginx/*    set ft=nginx
autocmd bufread,bufnewfile /etc/haproxy/*  set ft=haproxy


" keymaps
" disable arrows
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

" location list
map <f3> :lp<cr>
map <f4> :lne<cr>

" closer than the top-left of the keyboard
inoremap jk <esc>


" vim-go
let g:go_fmt_autosave=1


" lightline
let g:lightline = {'coloscheme':'wombat'}


" neomake
let g:neomake_error_sign = {'text': '▶'}
let g:neomake_python_enabled_makers = ['frosted', 'flake8']
autocmd! bufwritepost,bufenter * Neomake


" misc - doesn't work on neovim. yet...
set t_ti= t_te=  " http://www.shallowsky.com/linux/noaltscreen.html


" restore cursor position
augroup vimrcEx
    autocmd!
    autocmd bufreadpost * if line("'\'") > 0 && line("'\'") <= line("$") | exe "normal g`\"" | endif
augroup END
