return {
  { "m00qek/baleia.nvim", enabled = false },
  { "coder/claudecode.nvim", enabled = false },
  { "tpope/vim-dadbod", enabled = false },
  { "kristijanhusak/vim-dadbod-ui", enabled = false },
  { "kristijanhusak/vim-dadbod-completion", enabled = false },
  { "folke/persistence.nvim", enabled = false },
  { "nvim-mini/mini.animate", enabled = false },
  { "PaterJason/cmp-conjure", enabled = false },
  {
    "saghen/blink.cmp",
    optional = true,
    opts = function(_, opts)
      opts.sources.default = vim.tbl_filter(function(name)
        return name ~= "dadbod"
      end, opts.sources.default)
      if opts.sources.providers then
        opts.sources.providers.dadbod = nil
      end
    end,
  },
}
