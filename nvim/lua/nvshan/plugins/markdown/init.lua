local settings = require("settings")

return {
  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "mzlogin/vim-markdown-toc",
    ft = { "markdown" },
    cmd = { "GenToc", "UpdateToc", "GenTocGFM", "GenTocRedcarpet", "GenTocGitLab", "GenTocMarked" },
    init = function()
      vim.g.vmt_auto_update_on_save = 1
    end,
  },
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" },
    cmd = { "TableModeToggle", "TableModeEnable", "TableModeDisable", "TableModeRelign", "Tableize" },
  },
  {
    "epwalsh/obsidian.nvim",
    cond = settings.obsidian.enable,
    version = "*",
    ft = { "markdown" },
    cmd = {
      "ObsidianOpen",
      "ObsidianNew",
      "ObsidianQuickSwitch",
      "ObsidianFollowLink",
      "ObsidianBacklinks",
      "ObsidianTags",
      "ObsidianToday",
      "ObsidianYesterday",
      "ObsidianTomorrow",
      "ObsidianDailies",
      "ObsidianTemplate",
      "ObsidianSearch",
      "ObsidianLink",
      "ObsidianLinkNew",
      "ObsidianLinks",
      "ObsidianExtractNote",
      "ObsidianWorkspace",
      "ObsidianPasteImg",
      "ObsidianRename",
      "ObsidianToggleCheckbox",
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("nvshan.plugins.markdown.obsidian")
    end,
  },
}
