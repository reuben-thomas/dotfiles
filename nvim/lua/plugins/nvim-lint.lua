return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", "/home/reuben/.config/nvim/lua/misc/.markdownlint-cli2.yaml", "--" },
      },
    },
  },
}
