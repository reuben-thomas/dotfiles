return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      tex = { "tex-fmt" },
    },
    formatters = {
      ["tex-fmt"] = {
        prepend_args = { "--nowrap" },
      },
    },
  },
}
