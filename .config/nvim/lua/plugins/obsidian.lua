return {
  "epwalsh/obsidian.nvim",
  enabled = true,
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
        name = "obs",
        path = "~/Documents/Obsidian",
      },
      {
        name = "note",
        path = "~/Documents/Note",
      },
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
  },
}
