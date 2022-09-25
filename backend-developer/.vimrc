" Enable japanese
set encoding=utf-8
scriptencoding utf-8
" Enable Vim plugins/indentation by file type
filetype plugin indent on
" vim-plug Scripts-----------------------------
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" general plugins
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'scrooloose/syntastic'
Plug 'cohama/lexima.vim'
Plug 'ervandew/supertab'
Plug 'airblade/vim-gitgutter'
Plug 'yuxki/LineSplit.vim'
Plug 'yuxki/vim-switch-name'

" quickw
Plug 'yuxki/vim-pkm-api'
Plug 'yuxki/vim-quickw'

" fzf
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" for editting dockerfile
Plug 'ekalinin/Dockerfile.vim'

" for editting python
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

" for editting hcl
Plug 'jvirtanen/vim-hcl'

" for editting terraform
Plug 'hashivim/vim-terraform'

" color scheme
Plug 'nanotech/jellybeans.vim'

" for editting ansible
Plug 'pearofducks/ansible-vim'
Plug 'stephpy/vim-yaml', { 'for': 'yaml' }


call plug#end()
" End plug Scripts-------------------------


"----------------------------------------------------------
" Encoding
"----------------------------------------------------------
set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac
set ambiwidth=double

"----------------------------------------------------------
" Cursor
"----------------------------------------------------------
set whichwrap=b,s,h,l,<,>,[,],~
set number
set cursorline

nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

set backspace=indent,eol,start

"----------------------------------------------------------
" Status Line
"----------------------------------------------------------
set laststatus=2
set showmode
set showcmd
set ruler

"----------------------------------------------------------
" Tab and Indent
"----------------------------------------------------------
set expandtab
set tabstop=2
set softtabstop=2
set autoindent
set smartindent
set shiftwidth=2

"----------------------------------------------------------
" Search
"----------------------------------------------------------
set incsearch
set ignorecase
set smartcase
set hlsearch

" Press ESC key twice to toggle highlighting
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>
"----------------------------------------------------------
" Braces, brackets, and parentheses
"----------------------------------------------------------
set showmatch
set matchtime=3
set matchpairs& matchpairs+=<:>
source $VIMRUNTIME/macros/matchit.vim
let g:lexima_enable_newline_rules=0

"----------------------------------------------------------
" Instruction
"----------------------------------------------------------
set list
set wrap
set colorcolumn=100
set t_vb=
set novisualbell
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

"----------------------------------------------------------
" Colorscheme
"----------------------------------------------------------
"set jellybeans
colorscheme jellybeans
set t_Co=256
syntax enable

"----------------------------------------------------------
" Syntastic: python
"----------------------------------------------------------
syntax on

let g:syntastic_enable_signs = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_python_checkers=['flake8']
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['python'],
                           \ 'passive_filetypes': [] }

"----------------------------------------------------------
" Auto-Complete: python
"----------------------------------------------------------
autocmd FileType python setlocal completeopt-=preview

"----------------------------------------------------------
" Code Formatting: python
"----------------------------------------------------------
" python
" call autopep8 by <sift>+f
function! Preserve(command)
    " Save the last search.
    let search = @/
    " Save the current cursor position.
    let cursor_position = getpos('.')
    " Save the current window position.
    normal! H
    let window_position = getpos('.')
    call setpos('.', cursor_position)
    " Execute the command.
    execute a:command
    " Restore the last search.
    let @/ = search
    " Restore the previous window position.
    call setpos('.', window_position)
    normal! zt
    " Restore the previous cursor position.
    call setpos('.', cursor_position)
endfunction
function! Autopep8()
    call Preserve(':silent %!autopep8 --ignore=E501 -')
endfunction
autocmd FileType python nnoremap <S-f> :call Autopep8()<CR>

"----------------------------------------------------------
" Settings vim-gitgutter
"----------------------------------------------------------
set autoread
set updatetime=100

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction

highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

"----------------------------------------------------------
" Ansible Vim
"----------------------------------------------------------
let g:ansible_unindent_after_newline = 1
let g:ansible_yamlKeyName = 'yamlKey'
let g:ansible_attribute_highlight = "ob"
let g:ansible_name_highlight = 'd'
let g:ansible_extra_keywords_highlight = 1
let g:ansible_extra_keywords_highlight_group = 'Statement'
let g:ansible_normal_keywords_highlight = 'Constant'
let g:ansible_loop_keywords_highlight = 'Constant'

"----------------------------------------------------------
" fzf.vim
"----------------------------------------------------------
nnoremap <silent> <C-F> :Files<CR>
command! -bang -nargs=? -complete=dir Files
     \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'cat {}']}, <bang>0)
let g:fzf_layout = { 'down':  '40%'}

"----------------------------------------------------------
" vim-switch-name
"----------------------------------------------------------
let g:switchname_popup_upper_kebab = 0
let g:switchname_popup_lower_kebab = 0

"----------------------------------------------------------
" vim-quickw
"----------------------------------------------------------
nmap <silent> W :Quickw<CR>
"let g:quickw_word_pattern = '\k\+\|[(){}\[\]]'

"----------------------------------------------------------
" vim-seq-alpha
"----------------------------------------------------------
function! SeqAlpha ()
  normal iabcdefghijklmnopqrstuvwxyz
endfunction

command! SeqAlpha :call SeqAlpha()

"----------------------------------------------------------
" hashivim/vim-terrafor
"----------------------------------------------------------
let g:terraform_fmt_on_save = 1
