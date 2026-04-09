vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local git_enabled = false

require("nvim-tree").setup({
  filters = {
    dotfiles = false,
    git_ignored = false,
  },
  git = {
    enable = git_enabled, 
    ignore = false,
  },
})

vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>',
  { noremap = true, silent = true })

vim.keymap.set('n', '<leader>e', ':NvimTreeFocus<CR>',
  { noremap = true, silent = true })

vim.keymap.set('n', '<S-Tab>', function()
  if vim.bo.filetype == "NvimTree" then
    vim.cmd("wincmd p")
  end
end, { silent = true })

local api = require("nvim-tree.api")

vim.keymap.set("n", "<leader>tg", function()
  git_enabled = not git_enabled

  require("nvim-tree").setup({
    git = { enable = git_enabled, ignore = false }
  })

  api.tree.reload()

  if git_enabled then
    vim.notify("nvim-tree git icons: ON")
  else
    vim.notify("nvim-tree git icons: OFF")
  end
end, { desc = "Toggle nvim-tree git icons" })
