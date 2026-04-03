require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "python",
    "lua",
    "toml",
    "cpp",
    "bash",
  },

  highlight = {
    enable = true,
  },
})
