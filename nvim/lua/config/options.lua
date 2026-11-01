--
-- vim common
--
vim.opt.conceallevel = 1
vim.api.wrap = true
vim.g.ai_cmp = false
vim.opt.relativenumber = true
vim.go.background = "dark"
vim.opt.title = true
vim.g.autoformat = false
--
-- title
--
vim.opt.titlelen = 50
vim.opt.titlestring = "nvim %<%F%=%l/%L-%P"

--
-- python
--
vim.g.lazyvim_python_lsp = "ty"
vim.g.lazyvim_python_ruff = "ruff"
