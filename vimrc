" www.harakys.com
" @yarmand

let g:ctags_statusline=1	" To show tag name in status line.
let generate_tags=1	" To start automatically when a supported
let mapleader=","

" Directories for swp files
set swapfile
"set backupdir=~/tmp/vim
"set directory=~/tmp/vim

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
set mouse=a
set nofoldenable    " disable folding"

"
" Load all Bundles
"
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" ZoomWin configuration
map <Leader>o :ZoomWin<CR>

" convinient :Q :W
command Q q
command W w


" window resize
nnoremap <Leader>+ :res +5<CR>
nnoremap <Leader>= :res +5<CR>
nnoremap  <Leader>- :res -5<CR>
nnoremap <Leader>v+ :vertical res +15<CR>
nnoremap <Leader>v= :vertical res +15<CR>
nnoremap <Leader>v- :vertical res -15<CR>


" windows navigation
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l
nnoremap <Leader>c <C-w>c

" tabs navigation
nnoremap > :tabn<CR>
nnoremap <  :tabp<CR>


" CTags
map <Leader>frt :!ctags --extra=+f -R *<CR>
map <Leader>frtt :!ctags --extra=+f -R --exclude='*test*' *
map <Leader>frtr :!find app lib \| ctags --extra=+f -R -L -<CR>
map <Leader>ns :tnext<CR>


"Nice statusbar
set laststatus=2
set statusline+=%{fugitive#statusline()}
"set statusline+=%2*%-3.3n%0*\                " buffer number
"set statusline+=%f\                          " file name
"set statusline+=%h%1*%m%r%w%0*               " flags
"set statusline+=%=                           " right align
"set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

" set nocompatible


" Set encoding
set encoding=utf-8

 "Searching
set hlsearch
" clear search hilight
nnoremap <leader><Leader>/ :noh<cr>
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

autocmd BufWrite * silent! %s/[\r \t]\+$// " remove space fin de ligne

"set autowrite "Auto write change buffer
:au FocusLost * silent! :wa
"auto change dir to current buffer
"autocmd BufEnter * if expand("%:p:h") !~ '^/backup' | silent! lcd %:p:h | endif

"auto change dir to current buffer git repo root
autocmd BufEnter * silent! Gcd

" Spell checking
set spelllang=en
set spell
set spellsuggest=5

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>e :NERDTree<CR>
map <Leader>ee :NERDTreeFind<CR>
map <Leader><Leader>e :NERDTreeToggle<CR>

set tags=tags;

" ControlP configuration
map ff :CtrlPMRUFiles<CR>
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = { 'dir' : '\v[\/]\.(git|hg|svn)$|\.bundle$|vendor$' }
" let g:ctrlp_user_command = "find %s -type f | grep -v -e '\.git' -e '.bundle' -e 'vendor' -e tmp"
map <Leader>p :CtrlPClearCache<CR>

" FuzzyFinder
map ft :FufBufferTag<CR>
map fT :FufBufferTagAll<CR>
map fd :FufTagWithCursorWord<CR>
map fs :FufTag<CR>

" Go
map <Leader>gd :GoDef<CR>
map <Leader>gi :GoImports<CR>
map <Leader>gh :GoDoc<CR>
map <Leader>gt :GoTest<CR>
map <Leader>gl :GoLint<CR>
map <Leader>gr :GoRename<CR>

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_fmt_autosave = 0
autocmd BufWrite *.go :GoImports
autocmd BufWrite *.go :GoFmt
autocmd BufWrite *.go :GoLint

" ZoomWin configuration
map <Leader><Leader> :ZoomWin<CR>

" window resize
nnoremap <Leader>+ :res +5<CR>
nnoremap <Leader>= :res +5<CR>
nnoremap  <Leader>- :res -5<CR>

" windows navigation
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l

" TagList
map <Leader><Leader>t :TagbarToggle<CR>

" copy visual to a file
vmap <C-c> :w! /tmp/vim.copy.txt<CR>

" find in project
" let g:ruby_search_in_project = project_search_root."/app ".project_search_root."/lib ".project_search_root."/test"
let g:ruby_search_in_project = ""
map fw bvey :Ack <C-r>" <C-R>=ruby_search_in_project<CR>
map fp :Ack what_goes_here <C-R>=ruby_search_in_project<CR>

" next / previous
map fn :cnext<CR>
map f<S-N> :cprevious<CR>

" Gundo configuration
nmap <C-x><C-u> :GundoToggle<CR>

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
map<Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

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
let g:syntastic_quiet_messages = {'level': 'warnings'}

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
set t_Co=256
" set t_AB=^[[48;5;%dm
" set t_AF=^[[38;5;%dm
set guifont=Monaco:h12
set background=dark

let g:solarized_termcolors=256
colorscheme solarized

let g:kolor_italic=1                    " Enable italic. Default: 1
let g:kolor_bold=1                      " Enable bold. Default: 1
let g:kolor_underlined=0                " Enable underline. Default: 0
let g:kolor_alternative_matchparen=0    " Gray 'MatchParen' color. Default: 0
"colorscheme kolor
"colorscheme hybrid

" indent lines
let g:indentLine_char = '┆'
let g:indentLine_color_term = 239
let g:indentLine_color_dark = 2
let g:indentLine_color_tty_light = 4
let g:indent_guides_start_level = 2
let g:indentLine_noConcealCursor = 1

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" make Hammer quiet if gem github-markup is not installed
let g:HammerQuiet=1

if executable('coffeetags')
  let g:tagbar_type_coffee = {
        \ 'ctagsbin' : 'coffeetags',
        \ 'ctagsargs' : '--include-vars',
        \ 'kinds' : [
        \ 'f:functions',
        \ 'o:object',
        \ ],
        \ 'sro' : ".",
        \ 'kind2scope' : {
        \ 'f' : 'object',
        \ 'o' : 'object',
        \ }
        \ }
endif
" export NODE_PATH=/usr/local/lib/jsctags/

" bug workaround shortcuts
map <Leader><Leader>h :setfiletype html<CR>

" add another comment line shortcut
map <Leader>/ <Leader>c<space>
