return {
  "folke/snacks.nvim",
  opts = {
    dashboard = { enabled = false },
    picker = {
      hidden = true,
      ignored = true,
      layout = { fullscreen = true },
      sources = {
        explorer = {
          layout = { fullscreen = false },
          win = {
            list = {
              keys = {
                -- Conflicts with vim-tmux-navigator
                ["<c-j>"] = false,
                ["<c-k>"] = false,
                ["<a-h>"] = false,
                ["<a-j>"] = false,
                ["<a-k>"] = false,
                ["<a-l>"] = false,
              },
            },
          },
        },
        select = { layout = { fullscreen = false } },
      },
    },
  },
}
