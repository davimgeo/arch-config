function set_colorscheme(color)
  color = color or "gruvbox"
  vim.cmd.colorscheme(color)

  vim.o.termguicolors = true
  vim.o.background = "dark"

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

set_colorscheme()
