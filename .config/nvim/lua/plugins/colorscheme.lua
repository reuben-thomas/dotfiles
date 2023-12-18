return {

  { "jacoborus/tender.vim" },
  { "Mofiqul/vscode.nvim" },
  { "catppuccin/nvim" },
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup({ style = "darker" })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}
