-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Color Picker Keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<C-c>", "<cmd>PickColor<cr>", opts)
vim.keymap.set("i", "<C-c>", "<cmd>PickColorInsert<cr>", opts)

-- Vim Tmux Navigator
vim.keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", { silent = true })

-- Color Picker
vim.cmd([[hi FloatBorder guibg=NONE]]) -- if you don't want weird border background colors around the popup.

-- Completion Toggle
local cmp_enabled = false
vim.api.nvim_create_user_command("Complete", function()
  if cmp_enabled then
    require("cmp").setup.buffer({ enabled = false })
    vim.cmd("Copilot disable")
    print("Completion Disabled")
    cmp_enabled = false
  else
    require("cmp").setup.buffer({ enabled = true })
    vim.cmd("Copilot enable")
    print("Completion Enabled")
    cmp_enabled = true
  end
end, {})
