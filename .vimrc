"---------------------------------------------------------------------------
" Sainu's .vimrc
"---------------------------------------------------------------------------

"---------------------------------------------------------------------------

if &compatible
  set nocompatible
endif

let g:vim_home = expand('~/.vim')
let g:rc_dir = expand('~/.vim/rc')

function! s:source_rc(rc_file_name)
  let rc_file = expand(g:rc_dir . '/' . a:rc_file_name)
  if filereadable(rc_file)
    execute 'source' rc_file
  endif
endfunction

function! s:on_filetype() abort
  if execute('filetype') =~# 'OFF'
    silent! filetype plugin indent on
    syntax enable
    filetype detect
  endif
endfunction

augroup MyAutoCmd
  autocmd!
augroup END



"---------------------------------------------------------------------------
" Dein:
"

let s:dein_dir = '~/.cache/dein'
let s:dein_repo_dir = s:dein_dir . '/Shougo/dein.vim'
let s:rc_dir = '~/.vim/rc'

let &runtimepath = s:dein_repo_dir .",". &runtimepath

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#load_toml(g:rc_dir . '/dein.toml', { 'lazy': 0 })
  call dein#load_toml(g:rc_dir . '/deinlazy.toml', { 'lazy' : 1 })

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
"---------------------------------------------------------------------------



colorscheme solarized
set background=dark
if has('vim_starting') && !empty(argv())
  call s:on_filetype()
endif

syntax enable
filetype plugin indent on


"---------------------------------------------------------------------------
" Encoding:
"

set fileformat=unix
set fileformats=unix,dos,mac

set encoding=utf-8
set fileencodings=utf-8



"---------------------------------------------------------------------------
" Text:
"

" syntax on
" set guifont=RictyNerdFontAOPL-RegularForPowerline:h14

autocmd BufNewFile,BufRead *.jsx    setfiletype javascript
autocmd BufNewFile,BufRead *.es6    setfiletype javascript
autocmd BufNewFile,BufRead *.vue    setfiletype html


call s:source_rc('options.rc.vim')

call s:source_rc('mappings.rc.vim')



"---------------------------------------------------------------------------
" For UNIX:
"

" Use sh.  It is faster
set shell=sh




"---------------------------------------------------------------------------

set secure