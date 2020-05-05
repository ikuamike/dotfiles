"============================================================
" Michael Ikua's Vim configuration
"============================================================

set nocompatible              " be iMproved, required
filetype off                  " required

"======================== Vundle ============================

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"My plugins
Plugin 'mattn/emmet-vim'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tmhedberg/SimpylFold'
" Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"===================== Vundle End ===========================


"================== Lightline Config ========================

let g:lightline = {
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
        \ },
        \ 'colorscheme': 'darcula',
        \ 'component': {
        \   'lineinfo': ' %3l:%-2v',
        \ },
        \ 'component_function': {
        \   'readonly': 'LightlineReadonly',
        \   'fugitive': 'LightlineFugitive'
        \ },
        \ 'separator': { 'left': '', 'right': '' },
        \ 'subseparator': { 'left': '', 'right': '' }
        \ }
function! LightlineReadonly()
        return &readonly ? '' : ''
endfunction
function! LightlineFugitive()
        if exists('*fugitive#head')
                let branch = fugitive#head()
                return branch !=# '' ? ''.branch : ''
        endif
        return ''
endfunction

"================== Lightline Config End=======================

" SimpylFold options
let g:SimpylFold_fold_import = 0

function! FoldText()
        let foldsize = (v:foldend - v:foldstart)
        return getline(v:foldstart).' ('.foldsize.' lines)'
endfunction
setlocal foldtext=FoldText()

" Enable folding with the spacebar
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

" Option for tabline
set laststatus=2
set noshowmode

"For theme
set background=dark

"==== Emmet config ====
"redefine trigger key
let g:user_emmet_leader_key=','

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" Show the cursor position all the time
set ruler

" Enable syntax highlighting
syntax on

" Enhance command-line completion
set wildmenu

" Backup, swap and undo settings
set backup
set undofile
set backupdir=~/.vim/backups//
set directory=~/.vim/swaps//
set undodir=~/.vim/undo//

" Enable line numbers
set nonumber
set relativenumber
" Make tabs as wide as four spaces
"set tabstop=4

" Highlight current line
" set cursorline

" for python files
"au BufNewFile,BufRead *.py
"    \ set tabstop=4 |
"    \ set softtabstop=4 |
"    \ set shiftwidth=4 |
"    \ set textwidth=79 |
"    \ set expandtab |
"    \ set autoindent |
"    \ set fileformat=unix

"au BufNewFile,BufRead *.js, *.html, *.css
"    \ set tabstop=2 |
"    \ set softtabstop=2 |
"    \ set shiftwidth=2 |
"    \ set expandtab

" Turn on smart indenting
filetype indent on
set smartindent

" Custom Identation config
autocmd FileType html setlocal shiftwidth=2 tabstop=2 expandtab 
autocmd FileType js setlocal shiftwidth=2 tabstop=2 expandtab 
autocmd FileType sh setlocal shiftwidth=4 tabstop=4 

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif


