vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup()

vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', 
              { noremap = true, silent = true })

vim.keymap.set('n', '<leader>e', ':NvimTreeFocus<CR>',
              { noremap = true, silent = true })

-- volta para a janela antiga
vim.keymap.set('n', '<S-Tab>', function()
  if vim.bo.filetype == "NvimTree" then
    vim.cmd("wincmd p")  
  end
end, { silent = true })


