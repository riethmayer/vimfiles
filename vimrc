" must have!
command! -bar -nargs=* Rc e $MYVIMRC       " edit this file
command! -bar -nargs=* Rl :source $MYVIMRC " reload this file
set backspace=indent,eol,start " enable intuitive backspacing

" look & feel
if has("gui_mac") || has("gui_macvim")
  set guioptions-=T
  set guioptions-=L  
  set guifont=Inconsolata\ for\ Powerline:h18
  set transparency=7
endif

set term=screen-256color  " configure terminal
colorscheme hemisu        " select color scheme
set background=dark       " switch to dark version of color scheme

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
Bundle "gmarik/vundle"

if g:first_time
  silent exec ":BundleInstall"
endif

syntax enable             " turn on syntax highlighting
filetype plugin indent on " turn on file type detection

nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" handle cursor shape in terminal & tmux
if exists('$ITERM_PROFILE')
  if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"    
  endif
endif

" handle mouse
if has('mouse')
  set mouse=a
  if &term =~ "xterm" || &term =~ "screen"
    autocmd VimEnter *    set ttymouse=xterm2
    autocmd FocusGained * set ttymouse=xterm2
    autocmd BufEnter *    set ttymouse=xterm2
  endif
endif

" backup, swap & undo
set backup
set backupdir=~/.vim/tmp//
set history=5000
set noswapfile
set undodir=~/.vim/tmp//
set undofile
set undolevels=5000
