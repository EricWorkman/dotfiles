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
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'bitc/vim-bad-whitespace'
Plugin 'davidhalter/jedi-vim'
Plugin 'lambdalisue/vim-pyenv'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-fugitive'
Plugin 'ctrlpvim/ctrlp.vim'

" all plugins are defined
call vundle#end()            " required
filetype plugin indent on    " required

set splitbelow
set splitright

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
autocmd FileType python set omnifunc=pythoncomplete#Complete

" Javascript settings
au BufRead,BufNewFile *.js set tabstop=2
au BufRead,BufNewFile *.js set softtabstop=2
au BufRead,BufNewFile *.js set shiftwidth=2

" Python and cucumber feature settings
au BufRead,BufNewFile *.py,*.pyw,*.feature set expandtab
au BufRead,BufNewFile *.py,*.pyw,*.feature set textwidth=139
au BufRead,BufNewFile *.py,*.pyw,*.feature set tabstop=4
au BufRead,BufNewFile *.py,*.pyw,*.feature set smarttab
au BufRead,BufNewFile *.py,*.pyw,*.feature set softtabstop=4
au BufRead,BufNewFile *.py,*.pyw,*.feature set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw,*.feature set autoindent
au BufRead,BufNewFile *.py,*.pyw,*.feature match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.py,*.pyw,*.feature match BadWhitespace /\s\+$/
au         BufNewFile *.py,*.pyw,*.feature set fileformat=unix
au BufRead,BufNewFile *.py,*.pyw,*.feature let b:comment_leader = '#'

let python_highlight_all=1
syntax on

" just to be safe
set encoding=utf-8

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

" Theme
set background=dark
colorscheme jellybeans

" Nerdtree, make the focused window the file instead of Nerdtree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
au VimEnter *  NERDTree
au VimEnter * wincmd p

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

