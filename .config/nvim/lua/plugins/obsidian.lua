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
        name = "obs",
        path = "~/Documents/Obsidian",
      },
      {
        name = "note",
        path = "~/Documents/Notes",
      },
    },
    completion = {
      nvim_cmp = false,
      min_chars = 2,
      new_notes_location = "current_dir",
      prepend_note_id = true,
      prepend_note_path = false,
      use_path_only = false,
    },
  },
}
