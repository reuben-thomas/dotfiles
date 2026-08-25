return {
  {
    "rmehri01/onenord.nvim",
    lazy = true,
    opts = {
      custom_highlights = {
        -- Override default "Visual" (#EAEBED) which is difficult to distinguish from the background.
        light = {
          Visual = { bg = "#C2D5E8" },
          VisualNOS = { bg = "#C2D5E8" },
        },
      },
    },
  },
  { "habamax/vim-polar", lazy = true },
  {
    "navarasu/onedark.nvim",
    lazy = true,
    config = function()
      require("onedark").setup({
        style = "deep",
        transparent = true,
        lualine = {
          transparent = true,
        },
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = false,
      styles = {
        sidebars = "dark",
        floats = "dark",
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
      colorscheme = "onedark",
    },
  },
}
