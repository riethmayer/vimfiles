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

" bundle definitions
Bundle 'gmarik/vundle'
Bundle 'Lokaltog/vim-powerline'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'jeetsukumaran/vim-buffergator'
Bundle 'davidoc/taskpaper.vim'
Bundle 'vlasar/snipmate'
Bundle 'asux/snipmate-snippets'
Bundle 'benmills/vimux'
Bundle 'jgdavey/vim-turbux'
Bundle 'troydm/pb.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rvm'

syntax enable             " turn on syntax highlighting
filetype plugin indent on " turn on file type detection

" Install Frist Time {{{
  if g:first_time
    silent exec ":BundleInstall"
  endif
" }}}

" Prepare Tmp {{{
  silent execute '!find ~/.vim/tmp/ -type f -mtime +3 -exec rm {} \;'
  silent execute '!mkdir ~/.vim/tmp > /dev/null 2>&1'
" }}}

" Bindings {{{
  nno <leader>a :Ack<space>
  nno <leader>A :Ack <cword><cr>
  nno <leader>a+ :Ack --noignore-dir=
  nno <leader>e :Explore<cr>
  nno <Leader>b :BuffergatorOpen<cr>
  nno <leader>t :CtrlP<cr>
  nno <leader>p :NERDTreeToggle<cr>
  nno <leader>m <Plug>SendTestToTmux
  nno <leader>M <Plug>SendFocusedTestToTmux
  nno <leader>x <C-W>c
  nno <leader>X :bd<CR>
  nno <leader>v <C-W>v
  nno <leader>s <C-W>s
  nno <leader>n :NumberToggle<cr>
  nno <leader>rc :Rc<cr>
  nno <leader>rl :Rl<cr>
  nno ; :
  nno : ;
  vno ; :
  vno : ;
" }}}

" Global Variables {{{
  let NERDTreeQuitOnOpen=1
  let g:ctrlp_cmd = 'CtrlPBuffer'
  let g:ctrlp_cache_dir = $HOME.'/.vim/tmp/.cache/ctrlp'
  let g:ctrlp_reuse_window = 1
  let g:buffergator_suppress_keymaps=1
  let g:Powerline_symbols = 'fancy'
  let g:turbux_command_prefix = 'bundle exec'
  let g:no_turbux_mappings = 1
  let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.eunit$',
    \ 'file': '\.so$\|\.beam$\|\.DS_Store$'
    \ }
" }}}

" Basic Configuration {{{
  set backup
  set backupdir=~/.vim/tmp/
  set history=5000
  set noswapfile
  set undodir=~/.vim/tmp/
  set undofile
  set undolevels=5000
  set laststatus=2
  set relativenumber
  set ttyfast
  set synmaxcol=800
  set title
  set titlestring=%f%(\ [%M]%)
  set encoding=utf-8
  set fileformats=unix
  set hidden
  set wildmenu
  set wildmode=list:full
  set wildignore+=*.git,*.o,*.out,*.DS_Store,*.beam,*.jpg,*.bmp,*.gif,*.png,*.jpeg
" }}}

" Custom Function {{{
  function! NumberToggle()
    if(&relativenumber == 1)
      set number
    else
      set relativenumber
    endif
  endfunction

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

  " Task Paper
  function! s:OpenTodo(toFull)
    if (a:toFull == 1)
      sp | e ~/Dropbox/todo.taskpaper
    else
      e ~/Dropbox/todo.taskpaper
    endif
  endfunction
" }}}

command! -bar -nargs=* Todo call s:OpenTodo(1)
command! -bar -nargs=* Todof call s:OpenTodo(2)

autocmd FileType ruby      setlocal expandtab   shiftwidth=2 tabstop=2
autocmd FileType erlang    setlocal expandtab   shiftwidth=4 tabstop=4
autocmd FileType vim       setlocal expandtab   shiftwidth=2 tabstop=2
autocmd FileType make      setlocal noexpandtab shiftwidth=4 tabstop=4
autocmd FileType taskpaper setlocal expandtab   shiftwidth=2 tabstop=2
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" look & feel
if has("gui_mac") || has("gui_macvim")
  set guioptions-=T
  set guioptions-=L
  set guifont=Inconsolata\ for\ Powerline:h20
endif

set t_Co=256
set term=screen-256color
set background=dark
colorscheme hemisu
