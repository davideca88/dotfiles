" Davideca's ~/.config/nvim/init.vim
" <https://youtube.com/Davideca>
" Updated on 2022/09/07

" PLUGINS, using vim-plug
call plug#begin()
    Plug 'jiangmiao/auto-pairs'
    Plug 'preservim/nerdtree'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'ryanoasis/vim-devicons'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'vim-airline/vim-airline'
    Plug 'sheerun/vim-polyglot'
    Plug 'sainnhe/sonokai'

"    Plug 'crusoexia/vim-monokai'
"    Plug 'feline-nvim/feline.nvim'
call plug#end()

" CocNvim <tab>
inoremap <expr> <tab> coc#pum#visible() ? coc#pum#confirm() : "\<tab>"

" Vim-airline
let g:airline_theme='sonokai' " P: minimalist
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" NERDTree
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
nnoremap <C-o> :NERDTreeToggle<CR>

" GLOBAL CONFIGS ################################################################

" Maped keys
nnoremap q     :quit<CR>
nnoremap w     :write<CR>
nnoremap x     :wq<CR>
nnoremap <S-q> :q!<CR>
nnoremap <C-p> :source<CR>
nnoremap <C-right> :bn<CR>
nnoremap <C-left>  :bp<CR>
nnoremap <C-del>   :bd<CR>
map      <C-l> <C-w>l
map      <C-k> <C-w>k
map      <C-j> <C-w>j
map      <C-h> <C-w>h

" Colorscheme
"color monokai
"     ^ installed from 'crusoexia/vim-monokai'
color sonokai

set termguicolors
set noshowmode     " Remove 'insert' 'normal' etc from last line
set confirm        " Confirm saving
set wildmenu
set number         " Number on lines
set mouse=a        " Use mouse

filetype indent on " } <tab> options
set tabstop=4      " }
set shiftwidth=4   " }
set softtabstop=4  " }
set expandtab      " }

"inoremap <cr> <space><bs><cr> " }Attempt of disable 'autoindent' unindent
set cpoptions+=I               " }
set autoindent     " Auto indentation
" set cindent
" set smartindent

syntax on          " Syntax highlight
set nowrap         " No wrap line
set modelines=0    " Security
set cursorline
set clipboard=unnamedplus

" Live feedback
" set inccommand=split
