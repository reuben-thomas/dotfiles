return {
  { "habamax/vim-polar" },
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup({ style = "cool" })
    end,
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
