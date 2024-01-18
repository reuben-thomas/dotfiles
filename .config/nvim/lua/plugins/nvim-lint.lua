return {
  "mfussenegger/nvim-lint",
  opts = {
    linters = {
      markdownlint = {
        -- Only enable markdownlint if neovim is used to edit files that
        -- are not in the directory or any subdirectory of /home/$USER/Documents/
        condition = function()
          local current_path = vim.fn.expand("%:p")
          local documents_path = "/home/" .. vim.fn.expand("$USER") .. "/Documents/"
          return not string.match(current_path, "^" .. vim.pesc(documents_path))
        end,
      },
    },
  },
}
