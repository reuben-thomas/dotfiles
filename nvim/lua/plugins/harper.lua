return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        harper_ls = { enabled = false },
      },
    },
    init = function()
      local function toggle(state)
        if state then
          vim.lsp.enable("harper_ls")
        else
          vim.lsp.enable("harper_ls", false)
        end
      end

      vim.api.nvim_create_user_command("HarperToggle", function()
        local on = not vim.lsp.is_enabled("harper_ls")
        toggle(on)
        vim.notify("harper-ls " .. (on and "enabled" or "disabled"), vim.log.levels.INFO)
      end, { desc = "Toggle harper-ls" })

      LazyVim.on_very_lazy(function()
        Snacks.toggle({
          name = "Harper",
          get = function()
            return vim.lsp.is_enabled("harper_ls")
          end,
          set = toggle,
        }):map("<leader>uH")
      end)
    end,
  },

  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "harper-ls" } },
  },
}
