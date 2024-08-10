return {
  "zbirenbaum/copilot.lua",
  opts = {
    panel = {
      enabled = false,
    },
    suggestion = {
      enabled = true,
      auto_trigger = false,
      debounce = 0,
      keymap = {
        accept = "<M-l>",
        accept_word = false,
        accept_line = false,
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
    },
    filetypes = {
      yaml = true,
      markdown = true,
      help = true,
      gitcommit = true,
      gitrebase = true,
      ["."] = true,
    },
    copilot_node_command = "node", -- Node.js version must be > 18.x
    server_opts_overrides = {},
  },
}
