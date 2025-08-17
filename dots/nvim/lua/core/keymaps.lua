-- Set space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Tab options
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- safe buffer when leave
vim.api.nvim_create_autocmd({"BufLeave"}, {
  pattern = "*",
  command = "silent! update"
})

-- Close tab
vim.keymap.set('n', '<leader>x', ':bd<CR>',
              { noremap = true, silent = true })

