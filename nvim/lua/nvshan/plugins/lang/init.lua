return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewSto", "MarkdownPreviewToggle" },
    build = "cd app && npm install",
    ft = { "markdown" },
  }
}
