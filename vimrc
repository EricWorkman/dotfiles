set nocompatible              " required
filetype off                  " required

let mapleader = ","

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
" Someday I'll figure out why YouCompleteMe doesn't work correctly.
"Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'nanotech/jellybeans.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'bitc/vim-bad-whitespace'
Plugin 'davidhalter/jedi-vim'
Plugin 'lambdalisue/vim-pyenv'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-fugitive'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'elixir-lang/vim-elixir'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-eunuch'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'ervandew/supertab'
Plugin 'slashmili/alchemist.vim'
Plugin 'tpope/vim-endwise'

" all plugins are defined
call vundle#end()            " required
filetype plugin indent on    " required

set splitbelow
set splitright

" Theme
set background=dark
colorscheme jellybeans
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

" Python completion
autocmd FileType python                                          set omnifunc=pythoncomplete#Complete
autocmd FileType ruby                                            set omnifunc=syntaxcomplete#Complete

" Python, cucumber feature, ruby, and elixir settings
au BufRead,BufNewFile *.py,*.pyw,*.feature,*.rb,*.exs,*.ex,*.eex set expandtab
au BufRead,BufNewFile *.py,*.pyw,*.feature,*.exs,*.ex,*.eex      set textwidth=119
au BufRead,BufNewFile *.py,*.pyw,*.feature                       set tabstop=4
au BufRead,BufNewFile *.py,*.pyw,*.feature,*.rb,*.exs,*.ex,*.eex set smarttab
au BufRead,BufNewFile *.py,*.pyw,*.feature                       set softtabstop=4
au BufRead,BufNewFile *.py,*.pyw,*.feature                       set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw,*.feature,*.rb,*.exs,*.ex,*.eex set autoindent
au BufRead,BufNewFile *.py,*.pyw,*.feature,*.rb                  match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.py,*.pyw,*.feature,*.rb                  match BadWhitespace /\s\+$/
au         BufNewFile *.py,*.pyw,*.feature,*.rb,*.exs,*.ex,*.eex set fileformat=unix
au BufRead,BufNewFile *.py,*.pyw,*.feature,*.rb,*.exs,*.ex,*.eex let b:comment_leader = '#'

au BufRead,BufNewFile *.js,*.rb,*.exs,*.ex,*.eex                 set tabstop=2
au BufRead,BufNewFile *.js,*.rb,*.exs,*.ex,*.eex                 set softtabstop=2
au BufRead,BufNewFile *.js,*.rb,*.exs,*.ex,*.eex                 set shiftwidth=2

au BufRead,BufNewFile *.rb                                      match Error /\%81v.\+/
au BufRead,BufNewFile *.py                                      let python_highlight_all=1

syntax on

" Just to be safe
set encoding=utf-8

" Line numbers, http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/
set relativenumber
" toggle how line numbers are show
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

:au FocusLost * :set number
:au FocusGained * :set relativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

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

" Mac clipboard weirdness
set clipboard=unnamed
set history=4

" From bmoar, some shortcuts
" write file with sudo
map <leader>w :w !sudo tee %<CR>
" close current buffer
map <leader>bd :Bclose<cr>
" close all buffers
map <leader>ba :1,1000 bd!<cr>
" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Tags and autocomplete
:set tags=./tags;
:let g:easytags_dynamic_files = 1

autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
inoremap <C-@> <C-x><C-o>

map <leader>l :match Error /\%81v.\+/<cr>
