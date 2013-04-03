" VIM TIPS - source: http://vim.wikia.com/wiki/Best_Vim_Tips {{{

  " Basic {{{
    " <Esc> is the escape key or use <ctrl>[  sometimes written as  <C-[>

    " vimtutor    : starts vim editing a copy of a tutorial file -- very good.
    " i           : insert mode. Next keys typed are inserted into the file.
    " <Esc>       : Escape from insert mode so you can navigate and use edit commands (stop selecting)
    " h j k l     : move cursor ( h: ←  j: ↓  k: ↑  l: → )
    " A           : Append at end of line
    " o           : Insert at new line below
    " u           : undo last command, again and again
    " x           : delete character under cursor
    " dw          : delete everything right from the cursor to the start of next word (and put it into the default register)
    " dd          : delete line (and put it into the default register)
    " p           : paste the default register
    "
    " /myname     : search forward for myname
    "
    " :wq         : write and quit
    " :x          : write and quit
    " :w filename : write a copy of the file you are editing as filename
    " :q!         : quit without saving even if changes were made!
    " :help       : display help
    " <Tab>       : use tab completion to scroll through commands that start with what you typed
    "
    " Folding
    " za          : toggle
    " zc          : close
    " zo          : open
    " zR          : open all
    " zM          : close all

  " }}}

  " Still Basic {{{
    " COPY PASTE  (for CUTting lines use dd as described above)
    " v           : visual mode -- use to select text with cursor movement or mouse
    " y           : use to yank (copy) what was selected
    " <Esc>       : esc gets you back to the main mode
    "
    " ^ w e $     : bigger movements: beginning of line, word, end of word, end of line
    "
    " Modes:
    "   normal, insert and visual, there are others too
    "   <Esc>    takes you back to normal
    "
    " Enter a number before a command to repeat it, examples:
    "   10w      : skip forward 10 words
    "   10dd     : delete 10 lines
    "
    "Commands are case sensitive:
    "   c        : starts a change command
    "   C        : change to end of line (same as c$)
    "   ce       : change to end of word (a complete change command)
  " }}}

  " Great {{{
    " guu     : lowercase line
    " gUU     : uppercase line
    " ~       : invert case (upper->lower; lower->upper) of current character
    " gf      : open file name under cursor (SUPER)
    " ga      : display hex, ascii value of character under cursor
    " g8      : display hex value of utf-8 character under cursor
    " ggg?G   : rot13 whole file
    " xp      : swap next two characters around
    " CTRL-A,CTRL-X : increment, decrement next number on same line as the cursor
    " CTRL-R=5*5    : insert 25 into text
    " =             : (re)indent the text on the current line or on the area selected (SUPER)
    " =%            : (re)indent the current braces { ... }
    " G=gg          : auto (re)indent entire document
  " }}}

"}}}

" Must have {{{
  command! -bar -nargs=* Rc e $MYVIMRC       " edit this file
  command! -bar -nargs=* Rl :source $MYVIMRC " reload this file
  set backspace=indent,eol,start " enable intuitive backspacing
" }}}

" Disable everything before loading plugins {{{
  set nocompatible
  filetype off
" }}}

" Handle first runtime {{{
  let g:first_time=0
  if !isdirectory(expand("~/.vim/bundle/vundle"))
    call mkdir(expand("~/.vim/bundle", "p"))
    silent exec "!git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle"
    let g:first_time=1
  endif
" }}}

" Configure vundle manager {{{
  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()
  " basic help
  "   :BundleList          - list configured bundles
  "   :BundleInstall(!)    - install(update) bundles
  "   :BundleSearch(!) foo - search(or refresh cache first) for foo
  "   :BundleClean(!)      - confirm(or auto-approve) removal of unused
" }}}

" Bundles definitions {{{
  Bundle 'gmarik/vundle'
  Bundle 'Lokaltog/vim-powerline'
  Bundle 'kien/ctrlp.vim'
  Bundle 'mileszs/ack.vim'
  Bundle 'vim-scripts/tComment'
  " tComment help {{{
  "     gc{motion}   :: Toggle comments (for small comments within one line
  "                     the &filetype_inline style will be used, if
  "                     defined)
  "     gcc          :: Toggle comment for the current line
  "     gC{motion}   :: Comment region
  "     gCc          :: Comment the current line
  " }}}
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
  Bundle 'vim-scripts/kickAssembler-syntax'
  Bundle 'jnwhiteh/vim-golang'
  "Bundle 'mrmargolis/dogmatic.vim' not ready yet for this ;)
  Bundle 'vim-scripts/L9'
  Bundle 'vim-scripts/AutoComplPop'
" }}}

" Triger install when firstime {{{
  if g:first_time
    silent exec ":BundleInstall"
  endif
" }}}

" Renable syntax highlighting and file types detection {{{
  syntax enable
  filetype plugin indent on
" }}}

" Handling tmp, swap & undo {{{
  silent execute '!find ~/.vim/tmp/ -type f -mtime +3 -exec rm {} \;'
  silent execute '!mkdir ~/.vim/tmp > /dev/null 2>&1'

  " backup, swap & undo
  set backup
  set backupdir=~/.vim/tmp/
  set history=5000
  set noswapfile
  set undodir=~/.vim/tmp/
  set undofile
  set undolevels=5000
" }}}

" Plugins Configs {{{

  " Power line {{{
    let g:Powerline_symbols = 'fancy'
  " }}}

  " CtrlP {{{
    let g:ctrlp_cmd = 'CtrlPBuffer'
    let g:ctrlp_cache_dir = $HOME.'/.vim/tmp/.cache/ctrlp'
    let g:ctrlp_reuse_window = 1
  " }}}

  " NERDTree {{{
    let NERDTreeQuitOnOpen=1
  " }}}

  " Turbux {{{
    let g:turbux_command_prefix = 'zeus'
    let g:no_turbux_mappings = 1
  " }}}

" }}}

" Usefull custom functions {{{

  " NumberToggle() {{{
    function! NumberToggle()
      if(&relativenumber == 1)
        set number
      else
        set relativenumber
      endif
    endfunc
    command! -bar -nargs=* NumberToggle call NumberToggle()
  " }}}

  " StripTrainlingWhitespaces() {{{
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
  " }}}

  " OpenTodo(toFull) {{{
    function! s:OpenTodo(toFull)
      if (a:toFull == 1)
        sp | e ~/Dropbox/todo.taskpaper
      else
        e ~/Dropbox/todo.taskpaper
      endif
    endfunction
    command! -bar -nargs=* Todo call s:OpenTodo(1)
    command! -bar -nargs=* Todof call s:OpenTodo(2)
  " }}}

" }}}

" General settings {{{
  set ttyfast
  set synmaxcol=800
  set title
  set titlestring=%f%(\ [%M]%)
  set encoding=utf-8
  set fileformats=unix
  set hidden " hide buffers when not displayed
  set ttimeout
  set ttimeoutlen=10
  set notimeout
  set laststatus=2
  set relativenumber
  set wrap
  set formatoptions+=qrn1
  set formatoptions-=o
  set splitright
  set splitbelow
  set display=lastline
  set more
  set noerrorbells
  set novisualbell
  set visualbell t_vb=
  set report=2
  set scrolloff=3
  set sidescrolloff=3
  set pastetoggle=<leader>i
  au BufWinEnter * let w:m2=matchadd('ToLong', '\%>80v.\+', -1)
" }}}

" Searching {{{
    set gdefault
    set incsearch
    set hlsearch
" }}}

" Folding {{{
  set foldmethod=indent   "fold based on indent
  set foldnestmax=10      "deepest fold is 10 levels
  set nofoldenable        "dont fold by default
  set foldlevel=1         "this is just what i use
" }}}

" Wild ignores {{{
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
" }}}

" Autocmds {{{
  augroup FileTypes
    au!
    au FileType ruby   setlocal foldenable  foldmethod=syntax expandtab   shiftwidth=2 tabstop=2
    au FileType go     setlocal foldenable  foldmethod=syntax expandtab   shiftwidth=2 tabstop=2
    au FileType sh     setlocal foldenable  foldmethod=syntax expandtab   shiftwidth=2 tabstop=2
    au FileType erlang setlocal foldenable  foldmethod=syntax expandtab   shiftwidth=4 tabstop=4
    au FileType make   setlocal noexpandtab shiftwidth=4 tabstop=4
    au FileType vim    setlocal foldenable  foldmethod=marker foldlevel=0 expandtab shiftwidth=2 tabstop=2

    au BufNewFile,BufRead *.app.src set filetype=erlang
    au BufNewFile,BufRead *.config set filetype=erlang
  augroup END

  augroup Other
    au!
    au InsertLeave * set nopaste
  augroup END
" }}}

" Look & feel {{{
  if has("gui_mac") || has("gui_macvim")
    set guioptions-=T
    set guioptions-=L
    set guifont=Inconsolata\ for\ Powerline:h18
    set transparency=7
  endif

  set t_Co=256
  set term=screen-256color
  set background=dark
  colorscheme hemisu
" }}}

" Handle mouse {{{
  if has('mouse')
    set mouse=a
    if &term =~ "xterm" || &term =~ "screen"
      autocmd VimEnter *    set ttymouse=xterm2
      autocmd FocusGained * set ttymouse=xterm2
      autocmd BufEnter *    set ttymouse=xterm2
    endif
  endif
" }}}

" Bindings {{{
  " search via ack in project
  nno <leader>a :Ack<space>
  nno <leader>A :Ack <cword><cr>
  nno <leader>a+ :Ack --noignore-dir=
  " open standar explore
  nno <leader>e :Explore<cr>
  " open fuzzy finder
  nno <leader>t :CtrlP<cr>
  " open nerd tree
  nno <leader>o :NERDTreeToggle<cr>
  " switch relative/normal numbering
  nno <leader>n :NumberToggle<cr>
  " copy to system clipboard
  vno <leader>y :Pbyank<cr>
  " paste from system clipboard
  nno <leader>p :Pbpaste<cr>
  " run whole test file
  nmap <leader>M <Plug>SendTestToTmux
  " run test under cursor
  nmap <leader>m <Plug>SendFocusedTestToTmux
  " TODO describe me!
  nno <leader><leader> <c-^>
  " close current pane
  nno <leader>x <C-W>c
  " close buffer
  nno <leader>X :bd<CR>
  " split vertical
  nno <silent> <leader>v <C-W>v
  " split horizontal
  nno <silent> <leader>s <C-W>s
  " reset search
  nno <silent> <Leader>/ :nohlsearch<cr>
  " run custom vimux command
  nno <leader>c :VimuxPromptCommand<cr>
  " run last vimux command
  nno <leader>l :w<cr>:VimuxRunLastCommand<cr>
  " browse buffers
  nno <leader>b :CtrlPBuffer<cr>
  " edit vimrc
  nno <leader>rc :Rc<cr>
  " reload vimrc
  nno <leader>rl :Rl<cr>
  " open all foldings
  nno <leader><Space> zR
  " open current folding and close others
  nno <leader>z zMzvzz
  " reformat buffer
  nno <leader>f gg=G
  " TODO describe me!
  nno ; :
  nno : ;
  vno ; :
  vno : ;
  nno > >>
  nno < <<
  nmap < <<
  nmap > >>
  vmap < <gv
  vmap > >gv
" }}}

