--
-- markdown
--
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown", "txt" },
  callback = function()
    vim.b.autoformat = false
    vim.opt_local.spell = false
  end,
})
