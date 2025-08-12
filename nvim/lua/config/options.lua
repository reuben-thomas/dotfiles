-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.termguicolors = false
vim.opt.conceallevel = 1
vim.api.wrap = true
vim.g.copilot_enabled = false
vim.opt.relativenumber = true
vim.go.background = "dark"
vim.opt.title = true

vim.opt.titlelen = 50
vim.opt.titlestring = "nvim %<%F%=%l/%L-%P"
