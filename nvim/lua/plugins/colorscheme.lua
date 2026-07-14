return {
  { "rmehri01/onenord.nvim" },
  { "habamax/vim-polar" },
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup({
        style = "cool",
      })
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
      on_highlights = function(hl, c)
        local blend = require("tokyonight.util").blend_bg
        hl.MiniDiffOverAdd = { bg = blend(c.git.add, 0.25) }
        hl.MiniDiffOverDelete = { bg = blend(c.git.delete, 0.25) }
        hl.MiniDiffOverChange = { bg = blend(c.git.change, 0.4) }
        hl.MiniDiffOverContext = { bg = blend(c.git.change, 0.15) }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
