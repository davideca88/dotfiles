-- Deca's ~/.config/nvim/init.lua
--[[ made by a human ;)
CONTENTS                                                                                                                    |lua-contents|

1. Plugins (actually *paq-nvim)                                                                                             lua-paq
*see installation                                                                                                           lua-install-plugin-manager
    -> Plugin configs                                                                                                       lua-plugin-config
      -> Nvim-cmp                                                                                                           lua-plugin-config-cmp
      -> Sonokai                                                                                                            lua-plugin-config-sonokai
      -> Neocord                                                                                                            lua-plugin-config-neocord
      -> Lualine                                                                                                            lua-plugin-config-lualine
      -> Bufferline                                                                                                         lua-plugin-config-bufferline
      -> Toggleterm.nvim                                                                                                    lua-plugin-config-toggleterm
      -> Nvim-tree                                                                                                          lua-plugin-config-nvim-tree
      -> Nvim-autopairs                                                                                                     lua-plugin-config-nvim-autopairs
      -> Nvim-treesitter                                                                                                    lua-plugin-config-nvim-treesitter    
    
2. Options                                                                                                                  lua-options

3. Keymaps                                                                                                                  lua-keymaps

]]--
-- ####################################################################################################################################################################################################

-- PLUGINS, using paq-nvim                                                                                                  lua-*paq

require('paq') {
    { 'savq/paq-nvim' },
    { 'sainnhe/sonokai' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    { 'L3MON4D3/LuaSnip' },
    { 'rafamadriz/friendly-snippets' },
    { 'nvim-tree/nvim-web-devicons' },
    { 'nvim-lualine/lualine.nvim' },
    { 'akinsho/bufferline.nvim' },
    { 'akinsho/toggleterm.nvim' },
    { 'nvim-tree/nvim-tree.lua' },
    { 'windwp/nvim-autopairs' },
    { 'IogaMaster/neocord' },
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
}
-- ####################################################################################################################################################################################################

-- Plugin configs                                                                                                           lua-plugin-config

-- nvim-cmp                                                                                                                 lua-plugin-config-*cmp

-- local cmp = require('cmp')
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


local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

cmp.setup({

    snippet = {
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

--        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
--        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),

    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),

        ['<UP>'] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() then
                    cmp.close()
                end
                fallback()
            end
        }),
        ['<DOWN>'] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() then
                    cmp.close()
                end
                fallback()
            end
        }),
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
        ghost_text = false,
    }

}) -- end of cmp.setup

-- LSP configs (lsp-config and cmp_nvim_lsp)
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

-- template
--[[
lspconfig.<LSP>.setup {
    capabilities = capabilities
}
]]--


-- clangd for c/c++
lspconfig.clangd.setup {
    capabilities = capabilities,
    init_options = {
        fallbackFlags = { '-std=c23' },
    }
}

lspconfig.arduino_language_server.setup {
    capabilities = capabilities
}

-- pyright for python3.x
lspconfig.pyright.setup {
    capabilities = capabilities
}

-- luals for lua
lspconfig.lua_ls.setup {
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    "vim",
                    "guicursor",
                }
            }
        }
    }
}

-- auto parentheses
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

--[[
-- Signs for LSP on editor
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
]]--

-- Signs for LSP on editor (neovim 0.11) *note[1]
vim.diagnostic.config({
    virtual_text = true,
    update_in_insert = true, -- false,
--  underline = true,
    severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "", --"",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "󰋼",
			[vim.diagnostic.severity.HINT] = "󰌵",
		},
--[[		texthl = {
			[vim.diagnostic.severity.ERROR] = "Error",
			[vim.diagnostic.severity.WARN] = "Warn",
			[vim.diagnostic.severity.INFO] = "Info",
			[vim.diagnostic.severity.HINT] = "Hint",
		},
]]--
        numhl = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
	},
})

Diagnostics_under_cursor = function()
    vim.diagnostic.open_float(nil, { focusable = true })
end

-- Sonokai                                                                                                                  lua-plugin-config-*sonokai 
vim.cmd.colorscheme('sonokai')
vim.g.sonokai_style = 'atlantis'
vim.g.sonokai_better_performance = 0
vim.g.sonokai_transparent_background = 0 -- options: 0, 1, 2

-- Neocord                                                                                                                  lua-plugin-config-*neocord 
-- The setup config table shows all available config options with their default values:
require("neocord").setup({
    -- General options
    logo                = "auto",                     -- "auto" or url
    logo_tooltip        = nil,                        -- nil or string
    main_image          = "language",                 -- "language" or "logo"
    client_id           = "1157438221865717891",      -- Use your own Discord application client id (not recommended)
    log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
    debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
    blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
    file_assets         = {},                         -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
    show_time           = true,                       -- Show the timer
    global_timer        = true,                       -- if set true, timer won't update when any event are triggered
    enable_line_number  = true,

    -- Rich Presence text options
    editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
    file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
    git_commit_text     = "Committing changes",       -- Format string rendered when committing changes in git (either string or function(filename: string): string)
    plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
    reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
    workspace_text      = "Working on %s",            -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
    line_number_text    = "Line %s out of %s",        -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
    terminal_text       = "Using Terminal",           -- Format string rendered when in terminal mode.
})

-- Lualine                                                                                                                  lua-plugin-config-*lualine
require('lualine').setup({
    options = {
        theme = 'sonokai'
    }
})

-- Bufferline                                                                                                               lua-plugin-config-*bufferline
require('bufferline').setup{
    options = {
        theme = 'sonokai',
        separator_style = 'slant',
        diagnostics = 'nvim_lsp'
    }
}

-- Toggleterm.nvim                                                                                                          lua-plugin-config-*toggleterm
require('toggleterm').setup{
    open_mapping = [[<c-\>]],
    size = 30,
    hide_numbers = true,
    shading_factor = '10',
    close_on_exit = true,
    start_in_insert = true,
    insert_mappings = true,
    direction = 'float',    -- 'vertical', 'tab'
    float_opts = {
        border = 'curved', -- 'single' | 'double' | 'shadow' | 'curved'
        -- width = <value>,
        -- height = <value>,
        winblend = 10,
  }
}


-- Nvim-tree                                                                                                                lua-plugin-config-nvim-*tree
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Setup with some options
require("nvim-tree").setup({
    sort = {
      sorter = "case_sensitive",
    },

    view = {
      width = 30,
    },

    renderer = {
      group_empty = true,
    },

    filters = {
      dotfiles = true,
    },
})


-- Nvim-autopairs                                                                                                           lua-plugin-config-nvim-*autopairs

require('nvim-autopairs').setup()

-- Nvim-treesitter                                                                                                          lua-plugin-config-nvim-*treesitter
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- ####################################################################################################################################################################################################

-- Options                                                                                                                  lua-*options
guicursor="disable"
vim.opt.termguicolors = true
vim.opt.showmode = false           -- Remove modes on prompt (useful with *line like plugins)
vim.opt.confirm = true             -- Confirm saves
vim.opt.wildmenu = true
vim.opt.number = true              -- Number lines
vim.opt.hlsearch = false           -- Disable the highlight after search
vim.opt.mouse = "a"                -- Enable mouse

vim.cmd.filetype('indent on')  -- <tab> options
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.autoindent = true   -- Autoindent
vim.opt.cpoptions = vim.opt.cpoptions + "I"
vim.opt.indentkeys = vim.opt.indentkeys - ":'indentkeysi"

vim.cmd.syntax('on')        -- Syntax highlight
vim.g.c_syntax_for_h = 1
vim.opt.wrap = false        -- No wrap the line
vim.opt.modelines = 0       -- Security
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"

-- Restores the cursor after closing nvim (current: block, 1200ms, 600blinkon, 600blinkoff)
vim.cmd([[
    augroup RestoreCursorShapeOnExit
        autocmd!
        autocmd VimLeave * set guicursor=a:block-blinkwait1200-blinkon600-blinkoff600
    augroup END
]])


-- ####################################################################################################################################################################################################

-- Keymaps                                                                                                                  lua-*keymaps
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Set <Leader> to ,
vim.g.mapleader = ","

-- Modes
--   normal_mode = "n",
--   command_mode = "c",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",

-- template
-- keymap('mode', 'bind', 'command', opts)

-- NvimTree bind
keymap('n', '<C-_>', ':NvimTreeToggle<CR>', opts) -- (Ctrl-/) for NvimTree

-- Normal mode
keymap('n', 'q', ':quit<CR>', opts)         -- quit
keymap('n', 'w', ':write<CR>', opts)        -- save
keymap('n', 'x', ':wq<CR>', opts)           -- save and quit
keymap('n', '<S-q>', ':q!<CR>', opts)       -- force quit
keymap('n', '<C-p>', ':source<CR>', opts)   -- source
keymap('n', '<C-right>', ':bn<CR>', opts)   -- next buffer
keymap('n', '<C-left>', ':bp<CR>', opts)    -- previous buffer
keymap('n', '<C-del>', ':bd<CR>', opts)     -- buffer delete
keymap('n', '<C-l>', ':<C-w>l', opts)
keymap('n', '<C-k>', ':<C-w>k', opts)
keymap('n', '<C-j>', ':<C-w>j', opts)
keymap('n', '<C-h>', ':<C-w>h', opts)

keymap('n', 'S', ':lua require(\'sudowrite.lua\').sudowrite()<CR>', opts) -- sudowrite

keymap('n', '<Leader>1', ':lua Diagnostics_under_cursor()<CR>', opts) -- open_float for diagnostics

-- Insert mode
-- keymap('i', '<Leader>0', '<Esc>mmA;<Esc>`ma', opts)
keymap('i', '<Leader>0', '<Esc>A;', opts)
keymap('i', '<Leader>-', '<Esc>A {<CR> <BS><Esc>mmA<CR>}<Esc>`ma', opts)

-- ####################################################################################################################################################################################################

--[[
Notes:
    *1 Neovim sign-define deprecated <https://github.com/neovim/neovim/issues/33144>
]]--
-- Install extra                                                                                                   lua-*install-plugin-manager
--[[

# paq-nvim
git clone --depth=1 https://github.com/savq/paq-nvim.git \
    "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim

# sudowrite
wget https://gist.githubusercontent.com/oessessnex/d63ebe89380abff5a3ee70d6e76e4ec8/raw/d1692b5a2c5d9dcca59f0c84903fba141ffb7357/sudowrite.lua
--]]
