return {
  {
    "Olical/conjure",
    ft = "scheme",
    init = function()
      vim.g["conjure#filetypes"] = { "scheme" }
      vim.g["conjure#client#scheme#stdio#command"] = "petite"
      vim.g["conjure#client#scheme#stdio#prompt_pattern"] = "> $?"
    end,
    config = function()
      local function strip_sponsor()
        vim.schedule(function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if
              vim.api.nvim_buf_is_loaded(buf)
              and vim.api.nvim_buf_get_name(buf):match("conjure%-log%-")
            then
              local first = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1]
              if first and first:find("Sponsored by") then
                vim.api.nvim_buf_set_lines(buf, 0, 1, false, {})
              end
            end
          end
        end)
      end
      vim.api.nvim_create_autocmd("BufNew", {
        pattern = "conjure-log-*",
        group = vim.api.nvim_create_augroup("conjure_no_sponsor", { clear = true }),
        callback = strip_sponsor,
      })
      local log = require("conjure.log")
      local reset_soft = log["reset-soft"]
      log["reset-soft"] = function(...)
        reset_soft(...)
        strip_sponsor()
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "scheme" } },
  },
}
