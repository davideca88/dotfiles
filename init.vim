" Davideca's ~/.vimrc file
" <https://youtube.com/Davideca>
" Updated on 2021/08/01

" PLUGINS, using vim-plug
call plug#begin()
    Plug 'jiangmiao/auto-pairs'
    Plug 'preservim/nerdtree'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
" OLD
"   Plug 'codota/tabnine-vim'
"   Plug 'vim-airline/vim-airline'
call plug#end()

" NERDTree
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Maped keys
nnoremap q     :quit<CR>
nnoremap w     :write<CR>
nnoremap x     :wq<CR>
nnoremap <S-q> :q!<CR>
nnoremap <C-o> :NERDTreeToggle<CR>

" Colorscheme
color monokai
"     ^ installed from 'crusoexia/vim-monokai'

" Confirm saving
set confirm

" <tab> options
set wildmenu

" Number on lines
set number

" Use mouse
set mouse=a

" <tab> size
set tabstop=4
set shiftwidth=4
set expandtab

" Auto indentation
set autoindent
set smartindent

" Syntax highlight
syntax on

" No wrap line
set nowrap

" Security
set modelines=0

" Live feedback
set inccommand=split
