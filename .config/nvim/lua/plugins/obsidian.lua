return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    disable_frontmatter = true,
    workspaces = {
      {
        name = "main",
        path = "~/Documents/Obsidian",
      },
    },
    completion = {
      nvim_cmp = false,
    },
  },
}
