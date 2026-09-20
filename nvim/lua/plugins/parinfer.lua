return {
  "gpanders/nvim-parinfer",
  ft = "scheme",
  init = function()
    vim.g.parinfer_filetypes = { "scheme" }
  end,
}
