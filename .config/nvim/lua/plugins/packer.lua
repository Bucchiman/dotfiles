#!/usr/bin/env lua
--
-- FileName:     lua/plugins
-- Author: 8ucchiman
-- CreatedDate:  2023-04-02 18:32:14 +0900
-- LastModified: 2023-04-02 18:34:50 +0900
-- Reference: 8ucchiman.jp
--


--vim.cmd [[packadd packer.nvim]]
--
--return require('packer').startup(function(user)
--    use 'wbthomason/packer.nvim'
--
--    use 'rstacruz/vim-closer'
--
--    use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
--
--    -- Load on an autocommand event
--    use {'andymass/vim-matchup', event = 'VimEnter'}
--
--    -- Load on a combination of conditions: specific filetypes or commands
--    -- Also run code after load (see the "config" key)
--    use {
--      'w0rp/ale',
--      ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
--      cmd = 'ALEEnable',
--      config = 'vim.cmd[[ALEEnable]]'
--    }
--
--    -- Plugins can have dependencies on other plugins
--    use {
--      'haorenW1025/completion-nvim',
--      opt = true,
--      requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
--    }
--
--    -- Plugins can also depend on rocks from luarocks.org:
--    -- use {
--    --   'my/supercoolplugin',
--    --   rocks = {'lpeg', {'lua-cjson', version = '2.1.0'}}
--    -- }
--
--    -- You can specify rocks in isolation
--    use_rocks 'penlight'
--    use_rocks {'lua-resty-http', 'lpeg'}
--
--    -- Local plugins can be included
--    use {
--        'lewis6991/hover.nvim',
--        config = function()
--            require("hover").setup {
--                int = function()
--                    require("hover.providers.lsp")
--                end,
--                preview_opts = {
--                    border = nil
--                },
--                preview_window = false,
--                title = true
--            }
--            vim.keymap.set("n", "K", require("hover").hover, {desc = "hover.nvim"})
--            vim.keymap.set("n", "gK", require("hover").hover_select, {desc = "hover.nvim (select)"})
--        end
--    }
--
--    -- Plugins can have post-install/update hooks
--    use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}
--
--    -- Post-install/update hook with neovim command
--    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
--
--    -- Post-install/update hook with call of vimscript function with argument
--    use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }
--
--    -- Use specific branch, dependency and run lua file after load
--    -- use {
--    --   'glepnir/galaxyline.nvim',
--    --   branch = 'main',
--    --   config = function()
--    --       require'statusline'
--    --   end,
--    --   requires = {'nvim-tree/nvim-web-devicons', opt=true}
--    -- }
--
--    -- Use dependency and run lua function after load
--    use {
--      'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
--      config = function() require('gitsigns').setup() end
--    }
--
--    -- You can specify multiple plugins in a single call
--    use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}
--
--    -- You can alias plugin names
--    use {'dracula/vim', as = 'dracula'}
--end)

-- https://github.com/craftzdog/dotfiles-public/blob/master/.config/nvim/lua/craftzdog/plugins.lua
local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'svrana/neosolarized.nvim',
    requires = { 'tjdevries/colorbuddy.nvim' }
  }
  use { 'catppuccin/nvim', as = "catppuccin" }
  use 'nvim-lualine/lualine.nvim' -- Statusline
  use 'nvim-lua/plenary.nvim' -- Common utilities
  use 'onsails/lspkind-nvim' -- vscode-like pictograms
  use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/nvim-cmp' -- Completion
  use 'neovim/nvim-lspconfig' -- LSP

  use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  use 'glepnir/lspsaga.nvim' -- LSP UIs
  use 'L3MON4D3/LuaSnip'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use { 'numToStr/Comment.nvim',
    requires = {
      'JoosepAlviste/nvim-ts-context-commentstring'
    }
  }
  use 'norcalli/nvim-colorizer.lua'
  use 'folke/zen-mode.nvim'
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  use 'akinsho/nvim-bufferline.lua'
  -- use 'github/copilot.vim'

  use 'lewis6991/gitsigns.nvim'
  use 'dinhhuy258/git.nvim' -- For git blame & browse
  use({"ellisonleao/glow.nvim", config = function() require("glow").setup() end,})
end)

vim.cmd.colorscheme "catppuccin"
