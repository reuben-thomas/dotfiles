return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      scheme = { "schemat" },
      tex = { "tex-fmt" },
    },
    formatters = {
      schemat = {
        command = "schemat",
      },
      ["tex-fmt"] = {
        prepend_args = { "--nowrap" },
      },
    },
  },
}
