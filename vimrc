" vim tips at http://vim.wikia.com/wiki/Best_Vim_Tips

if $SHELL =~ 'fish'
  set shell='/bin/sh'
endif

" must have!
command! -bar -nargs=* Rc e $MYVIMRC       " edit this file
command! -bar -nargs=* Rl :source $MYVIMRC " reload this file
set backspace=indent,eol,start " enable intuitive backspacing

set nocompatible
filetype off

let g:first_time=0
if !isdirectory(expand("~/.vim/bundle/vundle"))
  call mkdir(expand("~/.vim/bundle", "p"))
  silent exec "!git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle"
  let g:first_time=1
endif

" configure vundle manager
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" basic help
" "   :BundleList          - list configured bundles
" "   :BundleInstall(!)    - install(update) bundles
" "   :BundleSearch(!) foo - search(or refresh cache first) for foo
" "   :BundleClean(!)      - confirm(or auto-approve) removal of unused
" bundles
"
" " bundle definitions
Bundle 'gmarik/vundle'
Bundle 'Lokaltog/vim-powerline'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-vividchalk'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-rvm'
Bundle 'tpope/vim-unimpaired'
Bundle 'vim-ruby/vim-ruby'
Bundle 'asux/vim-capybara'
Bundle 'Townk/vim-autoclose'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'othree/html5.vim'
Bundle 'mattn/gist-vim'
Bundle 'jimenezrick/vimerl'
Bundle 'davidoc/taskpaper.vim'
Bundle 'vlasar/snipmate'
Bundle 'asux/snipmate-snippets'
Bundle 'benmills/vimux'
Bundle 'jgdavey/vim-turbux'
Bundle 'troydm/pb.vim'
" Bundle 'mrmargolis/dogmatic.vim'

if g:first_time
  silent exec ":BundleInstall"
endif

syntax enable             " turn on syntax highlighting
filetype plugin indent on " turn on file type detection

" prepare tmp
silent execute '!find ~/.vim/tmp/ -type f -mtime +3 -exec rm {} \;'
silent execute '!mkdir ~/.vim/tmp > /dev/null 2>&1'

" backup, swap & undo
set backup
set backupdir=~/.vim/tmp//
set history=5000
set noswapfile
set undodir=~/.vim/tmp//
set undofile
set undolevels=5000

" fugitive
" Fugitive
no <leader>gd :Gdiff<cr>
nno <leader>gs :Gstatus<CR><C-W>15+
nno <leader>gw :Gwrite<cr>
nno <leader>ga :Gadd<cr>
nno <leader>gb :Gblame<cr>
nno <leader>gco :Gcheckout<cr>
nno <leader>gci :Gcommit<cr>
nno <leader>gm :Gmove<cr>
nno <leader>gr :Gremove<cr>
nno <leader>gl :Glog<cr>
" Cleanup fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete
autocmd BufReadPost fugitive://*
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif

" ack
nno <leader>a :Ack<space>
nno <leader>A :Ack <cword><CR>
nno <leader>a+ :Ack --noignore-dir=

" Explore
nno <leader>e :Explore<cr>

" power line
set laststatus=2              " show status line
let g:Powerline_symbols = 'fancy'

" CtrlP
nnoremap <leader>t :CtrlP<CR>
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_cache_dir = $HOME.'/.vim/tmp/.cache/ctrlp'
let g:ctrlp_reuse_window = 1

" NERDTree
nnoremap <leader>o :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1

" Turbux
let g:turbux_command_prefix = 'zeus'
let g:no_turbux_mappings = 1
nmap <leader>m <Plug>SendTestToTmux
nmap <leader>M <Plug>SendFocusedTestToTmux

nmap <leader>y <Plug>Pbyank
nmap <leader>p <Plug>Pbpaste
nnoremap <leader><leader> <c-^>

" line numbering & Toggle
set relativenumber
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc
nnoremap <leader>n :call NumberToggle()<CR>

" strip whitespace
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Task Paper
function! s:OpenTodo(toFull)
  if (a:toFull == 1)
    sp | e ~/Dropbox/todo.taskpaper
  else
    e ~/Dropbox/todo.taskpaper
  endif
endfunction
command! -bar -nargs=* Todo call s:OpenTodo(1)
command! -bar -nargs=* Todof call s:OpenTodo(2)

" general
set ttyfast
set synmaxcol=800
set title
set titlestring=%f%(\ [%M]%)
set encoding=utf-8
set fileformats=unix
set hidden " hide buffers when not displayed
set ttimeout
set ttimeoutlen=20
set notimeout

"folding
"za - toggle
"zc - close
"zo - open
"zR - open all
"zM - close all

set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

"

" configure wrapping
set wrap
set formatoptions+=qrn1
set formatoptions-=o

" shurtcut
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" move left
nno > >>
nno < <<

nmap < <<
nmap > >>
vmap < <gv
vmap > >gv

" windows closing
nno <leader>x <C-W>c
nno <leader>X :bd<CR>

" windows spliting
set splitright
set splitbelow
nno <silent> <leader>v <C-W>v
nno <silent> <leader>s <C-W>s

set wildmenu
set wildmode=list:full
set wildignore+=.hg,.git,.svn
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest
set wildignore+=*.spl
set wildignore+=*.sw?
set wildignore+=*.DS_Store
set wildignore+=*.pyc
set wildignore+=*.beam

autocmd FileType ruby   setlocal expandtab   shiftwidth=2 tabstop=2
autocmd FileType erlang setlocal expandtab   shiftwidth=4 tabstop=4
autocmd FileType vim    setlocal expandtab   shiftwidth=2 tabstop=2
autocmd FileType make   setlocal noexpandtab shiftwidth=4 tabstop=4

" searching
set gdefault
set incsearch
set hlsearch
nno <silent> <Leader>/ :nohlsearch<CR>

"folding settings
set foldmethod=indent   " fold based on indent
set foldnestmax=3       " deepest fold is 3 levels
set nofoldenable        " dont fold by default

" look & feel
if has("gui_mac") || has("gui_macvim")
  set guioptions-=T
  set guioptions-=L
  set guifont=Inconsolata\ for\ Powerline:h18
  set transparency=7
endif

set t_Co=256
if exists('$TMUX')
  set term=screen-256color  " configure terminal
else
  set term=xterm-256color  " configure terminal
endif

set term=screen-256color
set background=dark
colorscheme hemisu        " select color scheme

" handle mouse
if has('mouse')
  set mouse=a
  if &term =~ "xterm" || &term =~ "screen"
    autocmd VimEnter *    set ttymouse=xterm2
    autocmd FocusGained * set ttymouse=xterm2
    autocmd BufEnter *    set ttymouse=xterm2
  endif
endif

" Keybindings

nno <leader>c :VimuxPromptCommand<cr>
nno <leader>l :w<cr>:VimuxRunLastCommand<cr>
nno <leader>b :CtrlPBuffer<cr>
