-- Load packer if installed as opt
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  --  Packer 
  use 'wbthomason/packer.nvim'

  -- gruvbox
  --use { "ellisonleao/gruvbox.nvim" }
  use {'Mofiqul/vscode.nvim'}

  --  file explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' }
  }

  use 'nvim-tree/nvim-web-devicons'

  -- folding
  use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.config').setup({
        ensure_installed = {
          'python',
          'lua',
          'toml',
          'cpp',
          'bash',
        },
        highlight = { enable = true },
      })
    end
  }

  --  telescope
  use {
    'nvim-telescope/telescope.nvim',
    tag = '*',
    requires = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    }
  }

  use 'nvim-lua/plenary.nvim'

  --  ui enhancements
  use 'romgrk/barbar.nvim'      
  use 'lewis6991/gitsigns.nvim' 

  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
    end
  }

  -- lsp and autocomplete
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      -- LSP
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
      -- new adition
      {"ray-x/lsp_signature.nvim"},

      -- Autocomplete
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }

end)

