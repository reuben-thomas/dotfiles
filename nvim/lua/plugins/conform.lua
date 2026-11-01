return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      scheme = { "schemat" },
      tex = { "tex-fmt" },
      -- ocaml = { "ocamlformat" },
      ocaml = { "ocp-indent" },
      python = { "ruff_organize_imports", "ruff_format" },
    },
    formatters = {
      schemat = {
        command = "schemat",
      },
      ["tex-fmt"] = {
        prepend_args = { "--nowrap" },
      },
      -- ocamlformat = {
      --   prepend_args = {
      --     "--break-cases=all",
      --     "--if-then-else=vertical",
      --     "--break-infix=fit-or-vertical",
      --     "--break-fun-decl=fit-or-vertical",
      --     "--break-fun-sig=fit-or-vertical",
      --     "--module-item-spacing=preserve",
      --     "--type-decl=sparse",
      --   },
      -- },
    },
  },
}
