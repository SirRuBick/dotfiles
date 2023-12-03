return {
  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewSto", "MarkdownPreviewToggle" },
    build = "cd app && npm install",
    ft = { "markdown" },
  },
  {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    opts = {
        width_ratio = 0.7, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
        height_ratio = 0.7,
    },
  },
}
