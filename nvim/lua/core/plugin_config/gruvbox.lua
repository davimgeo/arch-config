function set_colorscheme(color) 
  color = color or "gruvbox" 
  vim.cmd.colorscheme(color) 

  local groups = {
    "Normal", "NormalFloat", "StatusLine", "StatusLineNC",
    "VertSplit", "SignColumn"
  }

  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, { bg = "none" })
  end
end 

set_colorscheme()
