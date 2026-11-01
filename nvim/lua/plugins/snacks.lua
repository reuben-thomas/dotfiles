return {
  "folke/snacks.nvim",
  keys = {
    { "<leader>e", "<leader>fE", desc = "Explorer Snacks (cwd)", remap = true },
    { "<leader>E", "<leader>fe", desc = "Explorer Snacks (root dir)", remap = true },
  },
  opts = {
    dashboard = { enabled = false },
    picker = {
      layout = { fullscreen = true },
      sources = {
        files = { hidden = true },
        grep = { hidden = true },
        explorer = {
          hidden = true,
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
