" www.harakys.com
" @yarmand

let g:ctags_statusline=1	" To show tag name in status line.
let generate_tags=1	" To start automatically when a supported

" Directories for swp files
set swapfile
set backupdir=~/tmp/vim
set directory=~/tmp/vim

syntax on             " syntax coloration
filetype plugin on
filetype plugin indent on

set number            " show line number
set ruler             " show row, col in statusbar
set nowrap            " disable line wrap
set showmatch         " show other bracket
set autoindent        " 
set tabstop=2
set softtabstop=2     " tab size
set shiftwidth=2      " indentation size
set expandtab         " use spaces for tab
"set list listchars=tab:\ \ ,trail:·
set visualbell

"Nice statusbar
set laststatus=2
"set statusline=
"set statusline+=%2*%-3.3n%0*\                " buffer number
"set statusline+=%f\                          " file name
"set statusline+=%h%1*%m%r%w%0*               " flags
"set statusline+=%=                           " right align
"set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

" set nocompatible

"
" Load all Bundles
"
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
filetype off 
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


" Set encoding
set encoding=utf-8

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

"autocmd BufWrite * silent! %s/[\r \t]\+$// " remove space fin de ligne
"set autowrite "Auto write change buffer
:au FocusLost * silent! :wa
autocmd BufEnter * if expand("%:p:h") !~ '^/backup' | silent! lcd %:p:h | endif

" Spell checking
set spelllang=en,fr
set spell
set spellsuggest=5

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>
map <C-n> :NERDTreeToggle<CR>

let g:project_search_root=getcwd()
set tags=tags;

" Command-T configuration
let g:CommandTMaxHeight=20
map tp :let g:project_search_root = '<C-R>=project_search_root<CR>'
map tt :CommandT <C-R>=project_search_root<CR><CR>

" FuzzyFinder
map fp :let g:project_search_root = '<C-R>=project_search_root<CR>'
map ff :FufFile <C-R>=project_search_root<CR>/**/<CR>
map ft :FufBufferTag<CR>
map fT :FufBufferTagAll<CR>
map fd :FufTagWithCursorWord<CR>
map fs :FufTag<CR>

" ZoomWin configuration
map <Leader><Leader> :ZoomWin<CR>

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>

" TagList
map ts :TlistToggle<CR>
map <C-s> :TlistToggle<CR>

" find in project
map <C-f> bvey :Ack <C-r>" <C-R>=project_search_root<CR>
map fw bvey :Ack <C-r>" <C-R>=project_search_root<CR>
" map <C-F> :Ack what_goes_here <C-R>=project_search_root
map fp :Ack what_goes_here <C-R>=project_search_root

" Gundo configuration
nmap <C-u> :GundoToggle<CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Hammer<CR>
endfunction

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

au BufRead,BufNewFile *.txt call s:setupWrapping()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
nmap <C-k> [e
nmap <C-j> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv
vmap <C-k> [egv
vmap <C-j> ]egv

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1

" gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" Use modeline overrides
set modeline
set modelines=10

" Turn off jslint errors by default
let g:JSLintHighlightErrorLine = 0

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

" % to bounce from do to end etc.
runtime! macros/matchit.vim

" Show (partial) command in the status line
set showcmd

if has("gui_running")
  " Automatically resize splits when resizing MacVim window
  autocmd VimResized * wincmd =
endif

" fix arrow behavior
if has("gui_macvim")
  let macvim_hig_shift_movement = 0
  set guioptions-=T " Start without the toolbar
  map <left> h
  map <down> j
  map <up> k
  map <right> l
  map <D-M-right> :tabNext<CR>
  map <D-M-left> :tabprevious<CR>
end

" Default color scheme
colors railscasts+
set guifont=Monaco:h12

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" make Hammer quiet if gem github-markup is not installed
let g:HammerQuiet=1
