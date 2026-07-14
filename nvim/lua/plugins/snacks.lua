return {
  "folke/snacks.nvim",
  opts = {
    dashboard = { enabled = false },
    picker = {
      hidden = true,
      ignored = true,
      sources = {
        explorer = {
          win = {
            list = {
              keys = {
                ["<c-j>"] = false,
                ["<c-k>"] = false,
              },
            },
          },
        },
      },
    },
  },
}
