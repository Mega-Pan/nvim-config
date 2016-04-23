" ~/.config/nvim/init.vim

" set plugin base dir
let s:editor_root=expand("~/.nvim")

" ========================================================== "
"                     VIM SETTINGS                           "
" ========================================================== "
"
set relativenumber  " Relative line numbers rock

set ruler           " Show the line and column number of the cursor position,
                    " separated by a comma.

set background=dark " When set to "dark", Vim will try to use colors that look good on dark backdrop

set shiftwidth=4    " Number of spaces to use for each step of (auto)indent.

set expandtab       " Use the appropriate number of spaces to insert a <Tab>.
                    " Spaces are used in indents with the '>' and '<' commands
                    " and when 'autoindent' is on. To insert a real tab when
                    " 'expandtab' is on, use CTRL-V <Tab>.

set smarttab        " When on, a <Tab> in front of a line inserts blanks
                    " according to 'shiftwidth'. 'tabstop' is used in other
                    " places. A <BS> will delete a 'shiftwidth' worth of space
                    " at the start of the line.

set incsearch       " While typing a search command, show immediately where the
                    " so far typed pattern matches.

set autoindent      " Copy indent from current line when starting a new line

" auto detect filetype
filetype plugin on

" allow easy insertion of one character with spacebar
nmap <Space> i_<Esc>r

" normal esc from terminal window
tnoremap <Esc> <C-\><C-n>

" fast dub j escape
inoremap jj <ESC>

" syntax highlight
syntax on

" allow verticle movement in display lines with tex, md, rst, and txt files
" set in ~/.config/nvim/ftplugin/<filetype>.vim
" noremap  <buffer> <silent> k gk
" noremap  <buffer> <silent> j gj

" ========================================================== "
"                    PLUGIN SETTINGS                         "
" ========================================================== "

" Fisrt, ensure to install the vim-plug plugin manager
" github.com/junegunn/vim-plug
call plug#begin('~/.nvim/plugged')
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/klen/python-mode.git'
Plug 'https://github.com/wgurecky/vimSum.git'
Plug 'https://github.com/junegunn/vim-easy-align.git'
Plug 'https://github.com/kien/ctrlp.vim'
Plug 'https://github.com/terryma/vim-multiple-cursors.git'
Plug 'https://github.com/SirVer/ultisnips.git'
Plug 'https://github.com/honza/vim-snippets.git'
Plug 'https://github.com/vim-scripts/taglist.vim'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/Shougo/deoplete.nvim.git'
Plug 'https://github.com/benekastah/neomake.git', { 'for': 'cpp,c' }
Plug 'lervag/vimtex'
call plug#end()

" Nerdtree settings
" launch nerdtree on entry if no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
set autochdir                " automatically change directory
let NERDTreeChDirMode=2

" Easy align settings
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Python mode settings
let pymode_rope = 0  " rope auto-complete causes significant delay in savetime
let g:pymode_lint_ignore = "E701,E702,E501,W0401"  " ignores line too long pep8 violations
let pymode_rope_vim_completion=0

" ctlp settings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" ultisnips settings
let g:UltiSnipsExpandTrigger="<c-Space>"

" Airline settings
let g:airline#extensions#tabline#enabled = 1

" deoplete settings
call remote#host#RegisterPlugin('python3', '~/.nvim/plugged/deoplete.nvim/rplugin/python3/deoplete', [
    \ {'sync': 1, 'name': '_deoplete', 'opts': {}, 'type': 'function'},
    \ ])
let g:deoplete#enable_at_startup=1
let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:deoplete#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
" tab complete
inoremap <expr><TAB> pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()
function! s:check_back_space() "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction "}}}

" neomake (check that c++ compiler supports c++14
let g:neomake_cpp_enabled_makers=['gcc']
let g:neomake_cpp_clang_args=["-std=c++14", "-Wextra", "-Wall"]
let g:neomake_cpp_gcc_args=["-std=c++14", "-Wextra", "-Wall"]

" ========================================================== "
"                    EXTRA FUNCTIONS                         "
" ========================================================== "

" show extra whitespace and tabs
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
