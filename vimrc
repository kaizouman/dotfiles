"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom vimrc file inspired by:
" Vim community:  vimrc_example.vim
"                 http://vim.wikia.com/wiki/Example_vimrc
" Valloric:       https://github.com/Valloric/dotfile
" Gmarik:         https://github.com/gmarik/vimfiles
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This file is UTF-8
scriptencoding utf-8
set encoding=utf-8

" Use Vim settings rather than vi ones
set nocompatible

filetype plugin indent on

set packpath+=~/dotfiles/vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            General settings                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" DISPLAY SETTINGS

" Syntax highlighting

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
endif
" Modify default syntastic highlighting.
highlight SyntasticError ctermbg=red guibg=red ctermfg=white guifg=white
" this makes sure that shell scripts are highlighted
" as bash scripts and not sh scripts
let g:is_posix = 1

" Cursor
set scrolloff=2         " 2 lines above/below cursor when scrolling
set showmatch           " show matching bracket (briefly jump)
set matchtime=2         " reduces matching parent blink time from the 5[00]ms def
" set cursorline          " highlights the current line

" Status bar
set showmode            " show mode in status bar (insert/replace/...)
set showcmd             " show typed command in status bar
set ruler               " show cursor position in status bar
" Always display the status line, even if only one window is displayed
set laststatus=2

" Title bar
" set title               " show file in titlebar

" When you type the first tab, it will complete as much as possible, the
" second tab hit will provide a list, the third and subsequent tabs will cycle
" through completion options so you can complete the file without further keys
set wildmode=longest,list,full
set wildmenu            " completion with menu

" display unprintable characters f12 - switches
set listchars=tab:▸\ ,eol:¬
set listchars+=nbsp:_,trail:•
set listchars+=extends:»,precedes:«
map <F12> :set list!<CR>

" The "longest" option makes completion insert the longest prefix of all
" the possible matches; see :h completeopt
set completeopt=menu,menuone,longest

" Switch between tabs using F3/F4
nnoremap <F3> :tabprevious<CR>
nnoremap <F4> :tabnext<CR>

" Configure search 
set hlsearch   " highlight search
set ignorecase " be case insensitive when searching
set smartcase  " be case sensitive when input has a capital letter
set incsearch  " show matches while typing
set gdefault   " search/replace global by default

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" EDITOR SETTINGS
set autoindent          " on new lines, match indent of previous line
set copyindent          " copy the previous indentation on autoindenting
set cindent             " smart indenting for c-like code
set cino=b0,g0,N-s,t0,(0,W4  " see :h cinoptions-values
set smarttab            " smart tab handling for indenting
set magic               " change the way backslashes are used in search patterns
set bs=indent,eol,start " Allow backspacing over everything in insert mode
set tabstop=4           " number of spaces a tab counts for
set shiftwidth=4        " spaces for autoindents
set softtabstop=4
set shiftround          " makes indenting a multiple of shiftwidth
set expandtab           " turn a tab into spaces
" allow backspace and cursor keys to cross line boundaries
set whichwrap+=<,>,h,l
set colorcolumn=80

" Python - PEP8
au BufNewFile,BufRead *.py
    \ set tabstop=4     |
    \ set softtabstop=4 |
    \ set shiftwidth=4  |
    \ set textwidth=79  |
    \ set expandtab     |
    \ set autoindent    |
    \ set fileformat=unix

" Web
au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2     |
    \ set softtabstop=2 |
    \ set shiftwidth=2

" Cpp
au BufNewFile,BufRead *.cpp,*.h
    \ set tabstop=2     |
    \ set softtabstop=2 |
    \ set shiftwidth=2  |
    \ set textwidth=79  |
    \ set expandtab     |
    \ set autoindent    |
    \ set fileformat=unix

" backup settings
set backup              " backup~ files
set backupdir=~/.vim/backup//,~/.tmp//,~/tmp//,/var/tmp//,/tmp//
set directory=~/.vim/backup//,~/.tmp//,~/tmp//,/var/tmp//,/tmp//
set undolevels=1000     " use many levels of undo
set undofile            " stores undo state even when files are closed
set undodir=~/.vim/backup//,~/.tmp//,~/tmp//,/var/tmp//,/tmp//

" misc settings
set fileformat=unix     " file mode is unix
set fileformats=unix,dos,mac   " detects unix, dos, mac file formats in that

set viminfo='20,\"500   " remember copy registers after quitting in the .viminfo
                        " file -- 20 jump links, regs up to 500 lines'

set hidden              " allows making buffers hidden even after unsaved changes
set history=1000        " remember more commands and search history
set autoread            " auto read when a file is changed from the outside
if has('mouse')
  set mouse=a           " enables the mouse in all mode
  set mousemodel=popup_setpos " Right-click on selection should bring up a menu
endif

" toggles vim's paste mode; when we want to paste something into vim from a
" different application, turning on paste mode prevents the insertion of extra
" whitespace
set pastetoggle=<F7>

set mousemodel=popup_setpos

" tries to avoid those annoying "hit enter to continue" messages
" if it still doesn't help with certain commands, add a second <cr>
" at the end of the map command
set shortmess=a

" By default, Vim will not use the system clipboard when yanking/pasting to
" the default register. This option makes Vim use the system default
" clipboard.
" Note that on X11, there are _two_ system clipboards: the "standard" one, and
" the selection/mouse-middle-click one. Vim sees the standard one as register
" '+' (and this option makes Vim use it by default) and the selection one as
" '*'.
" See :h 'clipboard' for details.
set clipboard+=unnamed

set guioptions=aA

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\ exe "normal! g'\"" |
	\ endif
  au BufWritePost .vimrc source $MYVIMRC
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Handle JSON as javascript
autocmd BufNewFile,BufRead *.json set ft=javascript

"------------------------------------------------------------
" Mappings

set winaltkeys=no       " turns of the Alt key bindings to the gui menu

" On azerty keyboard, "," is more accessible than "\"
":let mapleader = ","

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" Use CTRL+Arrows to navigate between windows
nmap <silent> <C-Up> :wincmd k<CR>
nmap <silent> <C-Down> :wincmd j<CR>
nmap <silent> <C-Left> :wincmd h<CR>
nmap <silent> <C-Right> :wincmd l<CR>

" NERDTree
map <F5> :NERDTreeToggle<CR>
map <F6> :NERDTreeFind<CR>

" YouCompleteMe specific settings
" do NOT request config file
let g:ycm_confirm_extra_conf = 0

