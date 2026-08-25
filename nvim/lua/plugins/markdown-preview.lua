return {
  "iamcco/markdown-preview.nvim",
  init = function()
    -- keep the preview tab open after switching to a non-markdown buffer
    vim.g.mkdp_auto_close = 0
    -- reuse a single preview tab for all markdown buffers
    vim.g.mkdp_combine_preview = 1
    -- refresh the combined preview when switching buffers
    vim.g.mkdp_combine_preview_auto_refresh = 1
  end,
}
