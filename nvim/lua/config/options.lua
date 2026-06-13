--
-- vim common
--
vim.opt.termguicolors = false
vim.opt.conceallevel = 1
vim.api.wrap = true
vim.g.copilot_enabled = false
vim.opt.relativenumber = true
vim.go.background = "dark"
vim.opt.title = true

--
-- title
--
vim.opt.titlelen = 50
vim.opt.titlestring = "nvim %<%F%=%l/%L-%P"

--
-- python
--
vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff"
