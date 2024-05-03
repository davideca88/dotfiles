-- Deca's ~/.config/nvim/init.lua

-- Vim Polyglot
vim.g.polyglot_disabled = 'autoindent'

-- PLUGINS, using vim-plug
local Plug = vim.fn['plug#']

vim.call('plug#begin')
    Plug ('jiangmiao/auto-pairs')
   
    Plug ('neovim/nvim-lspconfig')
    Plug ('hrsh7th/nvim-cmp')
    Plug ('hrsh7th/cmp-nvim-lsp')
    Plug ('hrsh7th/cmp-buffer')
    Plug ('hrsh7th/cmp-path')
    Plug ('hrsh7th/cmp-cmdline')
    
    Plug ('L3MON4D3/LuaSnip')
    Plug ('rafamadriz/friendly-snippets')
    
    Plug ('nvim-tree/nvim-web-devicons')
    Plug ('nvim-lualine/lualine.nvim')
    Plug ('akinsho/bufferline.nvim', { ['tag'] = '*' })

    Plug ('sheerun/vim-polyglot')
    Plug ('sainnhe/sonokai')

    Plug ('preservim/nerdtree')

    Plug ('andweeb/presence.nvim')

vim.call('plug#end')


-- nvim-cmp

local cmp = require('cmp')

local kind_icons = {
    Text = "",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰇽",
    Variable = "󰀫",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰅲",
    Misc = " ",
 }

cmp.setup({

    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
         require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

        ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),

    }),
     
    
    formatting = {
        fields = {"kind", "abbr", "menu"},
        format = function(entry, vim_item)
        -- Kind icons
        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
     -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
        -- Source
        vim_item.menu = ({ 
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
        })[entry.source.name]
        return vim_item
    end
  },
   
    window = {
        documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        },
    },
  
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, 
        { name = 'buffer' },
        { name = 'path' },
    }),

    experimental = {
        ghost_text = true,
    }

})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
--    require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--        capabilities = capabilities
--  }
require('lspconfig')['clangd'].setup {
    capabilities = capabilities
}

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Colorscheme 
vim.cmd.colorscheme('sonokai')
vim.g.sonokai_style = 'atlantis'
vim.g.sonokai_better_performance = 1
vim.g.sonokai_transparent_background = 0 -- options: 0, 1, 2


-- Lualine
require('lualine').setup({
    options = {
        theme = 'sonokai'
    }
})

-- Bufferline
require('bufferline').setup{
    options = {
        theme = 'sonokai',
        separator_style = 'slant'
    }
}

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

-- vim.cmd.colorscheme('sonokai')

vim.opt.termguicolors = true
vim.opt.showmode = false           -- Remove modes on prompt (useful with *line like plugins)
vim.opt.confirm = true             -- Confirm saves
vim.opt.wildmenu = true
vim.opt.number = true              -- Line numbers
vim.opt.mouse = "a"                -- Enable mouse

vim.cmd.filetype('indent on')  -- <tab> options
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.autoindent = true   -- Autoindent
vim.opt.cpoptions = vim.opt.cpoptions + "I"

vim.cmd.syntax('on')    -- Syntax highlight
vim.opt.wrap = false        -- No wrap the line
vim.opt.modelines = 0       -- Security
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"


-- LEGACY

-- PLUGINS ----------------------------

--    Plug ('ryanoasis/vim-devicons')
--    Plug ('williamboman/mason.nvim')
--    Plug ('williamboman/mason-lspconfig.nvim')
--    Plug ('neoclide/coc.nvim', { ['branch'] = 'release' })
--    Plug ('ms-jpq/coq_nvim', { ['branch'] = 'coq'} )
--    Plug ('ms-jpq/coq.artifacts', { ['branch'] = 'artifacts'} )

---------------------------------------

-- lsp-config
-- require("lspconfig").ccls.setup{}

-- CoCNvim <tab>
--vim.cmd([[ inoremap <expr> <tab> coc#pum#visible() ? coc#pum#confirm() : "\<tab>" ]])
--local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
--vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)

-- Mason

--require("mason").setup()
--require("mason-lspconfig").setup()
--require("lspconfig").ccls.setup{}

-- Vim-airline
-- vim.g.airline_theme = "sonokai" -- Previous: minimalist
-- vim.g.airline_powerline_fonts = 1
-- vim.cmd([[ let g:airline#extensions#tabline#enabled = 1 ]])
