return {
  "lervag/vimtex",
  lazy = false, -- lazy-loading will disable inverse search
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_compiler_method = "tectonic"
    vim.g.vimtex_compiler_tectonic = {
      options = {
        "--keep-logs",
        "--synctex",
        "-Z",
        "shell-escape",
        "--bundle",
        "https://data1.fullyjustified.net/tlextras-2022.0r0.tar",
      },
    }

    -- tectonic has no continuous mode, so compile on save instead
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = { "*.tex" },
      callback = function()
        if vim.b.vimtex ~= nil then
          vim.cmd("VimtexCompileSS")
        end
      end,
    })
  end,
}
