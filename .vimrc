"============================================================
" Michael Ikua's Vim configuration
"============================================================

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
set nocompatible

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
set number

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif


