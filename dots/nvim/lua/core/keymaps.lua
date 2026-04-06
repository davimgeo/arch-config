-- Set space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Tab options
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- safe buffer when leave
vim.api.nvim_create_autocmd({"BufLeave"}, {
  pattern = "*",
  command = "silent! update"
})

-- Close tab and save buffer
vim.keymap.set('n', '<leader>x', ':update | bd<CR>', 
              { noremap = true, silent = true })

-- Runs currently python code
vim.api.nvim_set_keymap("n", "<localleader>pp", "<cmd>!python3 %<CR>",
              { noremap = false, silent = true })

-- Copies into buffer with ctrl + c
vim.api.nvim_set_keymap(
  "v",          
  "<C-c>",      
  '"+y', 
  { noremap = true, silent = true }
)

-- Ctrl + A to select all lines
vim.api.nvim_set_keymap(
  "n",              
  "<C-a>",          
  "ggVG", 
  { noremap = true, silent = true }
)

-- move lines like Alt + arrows in vscode
vim.keymap.set({"n", "i", "v"}, "<A-k>", ":m .-2<CR>==")
vim.keymap.set({"n", "i", "v"}, "<A-j>", ":m .+1<CR>==")

-- use tab to '>' and shift + tab to space backward
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent forward" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Indent backward" })

-- save buffer with ctrl + s
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<Esc>:w<CR>", { desc = "Save file" })

-- ctrl + j to enable and disabnle terminal
local term_buf = nil
local term_win = nil

function ToggleTerm()
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_close(term_win, true)

    if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
      vim.api.nvim_buf_delete(term_buf, { force = true })
    end

    term_win = nil
    term_buf = nil
  else
    vim.cmd("belowright split")
    vim.cmd("resize 15")
    vim.cmd("terminal")

    term_win = vim.api.nvim_get_current_win()
    term_buf = vim.api.nvim_get_current_buf()

    vim.defer_fn(function()
      if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
        vim.api.nvim_chan_send(vim.b.terminal_job_id, "source ~/venv/bin/activate\n")
      end
    end, 100)

    vim.cmd("startinsert")
  end
end

vim.keymap.set("n", "<C-j>", ToggleTerm, { silent = true })
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><cmd>lua ToggleTerm()<CR>]], { silent = true })
