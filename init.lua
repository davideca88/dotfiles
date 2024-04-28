-- Deca's ~/.config/nvim/init.lua

local g = vim.g
local o = vim.opt

-- PLUGINS, using vim-plug
local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
    Plug ('jiangmiao/auto-pairs')
    Plug ('preservim/nerdtree')
    Plug ('neoclide/coc.nvim', { ['branch'] = 'release' })
    Plug ('ryanoasis/vim-devicons')
    Plug ('kyazdani42/nvim-web-devicons')
    Plug ('vim-airline/vim-airline-themes')
    Plug ('vim-airline/vim-airline')
    Plug ('sheerun/vim-polyglot')
    Plug ('sainnhe/sonokai')

    Plug ('andweeb/presence.nvim')
--     Plug ('jiriks74/presence.nvim')

--    Plug ('crusoexia/vim-monokai')
--    Plug ('feline-nvim/feline.nvim')
vim.call('plug#end')

-- CoCNvim <tab>
vim.cmd([[ inoremap <expr> <tab> coc#pum#visible() ? coc#pum#confirm() : "\<tab>" ]])
-- local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}   
-- vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)

-- Vim-airline
vim.g.airline_theme = "sonokai" -- Previous: minimalist
vim.g.airline_powerline_fonts = 1
vim.cmd([[ let g:airline#extensions#tabline#enabled = 1 ]])

-- NERDTree
-- Use <C-o> to open/close NERDTree
vim.cmd([[
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
    nnoremap <C-o> :NERDTreeToggle<CR>
]])

vim.cmd([[    
    nnoremap q          :quit<CR>
    nnoremap w          :write<CR>
    nnoremap x          :wq<CR>
    nnoremap <S-q>      :q!<CR>
    nnoremap <C-p>      :source<CR>
    nnoremap <C-right>  :bn<CR>
    nnoremap <C-left>   :bp<CR>
    nnoremap <C-del>    :bd<CR>
    map      <C-l>      <C-w>l
    map      <C-k>      <C-w>k
    map      <C-j>      <C-w>j
    map      <C-h>      <C-w>h
]])

vim.cmd([[ color sonokai ]])

vim.opt.termguicolors = true
-- vim.opt.noshowmode = true          -- Remove modes on prompt (useful with plugins like airline)
vim.opt.confirm = true             -- Confirm saves
vim.opt.wildmenu = true
vim.opt.number = true              -- Line numbers
vim.opt.mouse = "a"                -- Enable mouse

vim.cmd([[ filetype indent on ]])  -- <tab> options
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.autoindent = true   -- Autoindent
vim.opt.cpoptions = vim.opt.cpoptions + "I"

vim.cmd([[ syntax on ]])    -- Syntax highlight
vim.opt.wrap = false        -- No wrap the line
vim.opt.modelines = 0       -- Security
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
