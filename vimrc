set nocompatible              " required
filetype off                  " required

set nobackup
set noswapfile

let mapleader = ","

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Plugins
" Code Definitions
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
" Elixir
Plugin 'elixir-lang/vim-elixir'
Plugin 'slashmili/alchemist.vim'
" Folding
Plugin 'tmhedberg/SimpylFold'
" Nav
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'christoomey/vim-tmux-navigator'
" Python
Plugin 'nvie/vim-flake8'
Plugin 'davidhalter/jedi-vim'
Plugin 'lambdalisue/vim-pyenv'
Plugin 'pearofducks/ansible-vim'
" Ruby
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
" Sugar
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-endwise'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'godlygeek/tabular'
" Syntax
Plugin 'scrooloose/syntastic'
Plugin 'bitc/vim-bad-whitespace'
" Theme
Plugin 'nanotech/jellybeans.vim'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

call vundle#end()            " required
filetype plugin indent on    " required

" Syntastic settings
set laststatus=2
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Window splitting
set splitbelow
set splitright

" Theme
set background=dark
colorscheme jellybeans
" Highlighting
set hlsearch
highlight Search ctermbg=white ctermfg=black

" Navigation remaps
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Backspace like a normal person
set backspace=indent,eol,start

" Enable folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" Sane editing defaults
syntax on
set textwidth=99
set expandtab
set smarttab
syntax match BadWhitespace /^\t\+/
syntax match BadWhitespace /\s\+$/
set fileformat=unix
let b:comment_leader = '#'
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Python
au FileType python set omnifunc=pythoncomplete#Complete
au FileType python set tabstop=4
au FileType python set softtabstop=4
au FileType python set shiftwidth=4
au FileType python let python_highlight_all=1

" Ruby
au FileType ruby,eruby match Error /\%81v.\+/
au FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
au FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
au FileType ruby,eruby let g:rubycomplete_rails = 1

" Just to be safe
set encoding=utf-8

" Line numbers
" http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/
set rnu
set nu
" toggle how line numbers are show
function! NumberToggle()
  if(&relativenumber == 1)
    set rnu!
    set nu
  else
    set rnu
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

":au FocusLost * :set number
":au FocusGained * :set relativenumber
"autocmd InsertEnter * :set number
"autocmd InsertLeave * :set relativenumber

" For jedi-vim
"python with virtualenv support
if jedi#init_python()
  function! s:jedi_auto_force_py_version() abort
    let major_version = pyenv#python#get_internal_major_version()
    call jedi#force_py_version(major_version)
  endfunction
  augroup vim-pyenv-custom-augroup
    autocmd! *
    autocmd User vim-pyenv-activate-post   call s:jedi_auto_force_py_version()
    autocmd User vim-pyenv-deactivate-post call s:jedi_auto_force_py_version()
  augroup END
endif

" vim + tmux clipboard weirdness
if $TMUX == ''
  set clipboard+=unnamed
endif

set history=200

" From bmoar, some shortcuts
" write file with sudo
map <leader>w :w !sudo tee %<CR>

" Exuberant Tags
set tags=./tags;
let g:easytags_dynamic_files = 1
inoremap <C-@> <C-x><C-o>

" Highlight lines too long
map <leader>l :match Error /\%81v.\+/<cr>

" Multipurpose Tab Key
" Indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" Rename current function
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>n :call RenameFile()<cr>

" Splitjoin mappings
map <leader>s :SplitjoinSplit<Enter>
map <leader>j :SplitjoinJoin<Enter>

" FZF mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Tabularize mappings
nmap <leader>a= :Tabularize /=<CR>
vmap <leader>a= :Tabularize /=<CR>
nmap <leader>a: :Tabularize /:\zs<CR>
vmap <leader>a: :Tabularize /:\zs<CR>
nmap <leader>a{ :Tabularize /{<CR>
vmap <leader>a{ :Tabularize /{<CR>
nmap <silent><Bar> <Bar><Esc>:Tabularize /<Bar><CR>a
vmap <silent><Bar> <Bar><Esc>:Tabularize /<Bar><CR>a
