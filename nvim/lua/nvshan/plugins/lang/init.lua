return {
  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    "ellisonleao/glow.nvim",
    cond = false,
    cmd = "Glow",
    opts = {
      width_ratio = 0.7, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
      height_ratio = 0.7,
    },
  },
}
