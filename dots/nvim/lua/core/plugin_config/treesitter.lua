

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
