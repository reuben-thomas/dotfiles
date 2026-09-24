return {
  {
    "Olical/conjure",
    ft = "scheme",
    init = function()
      -- Don't attach to any of the other dialects Conjure supports.
      vim.g["conjure#filetypes"] = { "scheme" }

      vim.g["conjure#client#scheme#stdio#command"] = "petite"
      vim.g["conjure#client#scheme#stdio#prompt_pattern"] = "> $?"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "scheme" } },
  },
}
