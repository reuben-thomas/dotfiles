return {
  "smart-splits-nvim/smart-splits.nvim",
  lazy = false, -- backend must load at startup to set tmux's @pane-is-vim
  opts = { mux = { backend = "smart-splits-backend-tmux" } },
  dependencies = {
    { "smart-splits-nvim/backend-tmux", main = "smart-splits-backend-tmux" },
  },
}
