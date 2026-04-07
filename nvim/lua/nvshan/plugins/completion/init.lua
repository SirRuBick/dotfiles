local settings = require("settings")

return {
  {
    "hrsh7th/nvim-cmp",
    commit = "ca4d333",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-emoji",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        build = vim.fn.has("win32") == 0 and "echo 'note: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
          or nil,
        dependencies = {
          "rafamadriz/friendly-snippets",
        },
      },
      {
        "Exafunction/codeium.nvim",
        cond = settings.use_codeium,
        cmd = "Codeium",
        opts = {},
      },
    },
    config = function()
      require("nvshan.plugins.completion.cmp")
    end,
  },
  {
    "github/copilot.vim",
    cond = settings.use_copilot,
    cmd = "Copilot",
    event = "InsertEnter",
    init = function()
      vim.g.copilot_no_tab_map = true
    end,
  },
}
