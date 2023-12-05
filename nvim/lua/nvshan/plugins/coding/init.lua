return {
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    keys = {
      { "<leader>fd", "<cmd>TodoTelescope<CR>", desc = "Find TODOs" },
      { "<leader>xd", "<cmd>TodoTrouble<CR>",   desc = "Trouble TODOs" },
    },
  },
  {
    "numToStr/Comment.nvim",
    event = { "CursorHold", "CursorHoldI" },
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("nvshan.plugins.coding.Comment")
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvshan.plugins.coding.autopairs")
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<CR>",                     desc = "Trouble Toggle" },
      { "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<CR>", desc = "Trouble Workspace Diagnostics" },
      { "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<CR>",  desc = "Trouble Document Diagnostics" },
      { "<leader>xl", "<cmd>Trouble loclist<CR>",                   desc = "Trouble Location List" },
      { "<leader>xq", "<cmd>Trouble quickfix<CR>",                  desc = "Trouble Quickfix" },
      { "<leader>xr", "<cmd>Trouble lsp_references<CR>",            desc = "Trouble References" },
    },
    config = function()
      require("nvshan.plugins.coding.trouble")
    end,
  },
  {
    "RRethy/vim-illuminate",
    event = { "CursorHold", "CursorHoldI" },
    config = function()
      require("nvshan.plugins.coding.illuminate")
    end
  },
  {
    "SUSTech-data/wildfire.nvim",
    -- TODO: Can we lazy load this when <CR> is pressed?
    event = { "BufRead", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      surrounds = {
        { "(", ")" },
        { "{", "}" },
        { "<", ">" },
        { "[", "]" },
      },
      keymaps = {
        init_selection = "<CR>",
        node_incremental = "<CR>",
        node_decremental = "<BS>",
      },
      filetype_exclude = { "qf" }, --keymaps will be unset in excluding filetypes
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability;
    event = { "BufRead", "BufNewFile" },
    opts = {
      keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        visual = "S",
        visual_line = "gS",
        delete = "ds",
        change = "cs",
        change_line = "cS",
      },
    },
    aliases = {
      ["a"] = ">",
      ["b"] = ")",
      ["B"] = "}",
      ["r"] = "]",
      ["q"] = { '"', "'", "`" },
      ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufNewFile", "BufReadPost" },
    config = function()
      require("nvshan.plugins.coding.lint")
    end
  },
  {
    "kevinhwang91/nvim-ufo",
    cmds = {
      "UfoEnable",
      "UfoDisable",
      "UfoInspect",
      "UfoAttach",
      "UfoDetach",
      "UfoEnableFold",
      "UfoDisableFold"
    },
    dependencies = {
      "kevinhwang91/promise-async"
    },
    opts = {
      open_fold_hl_timeout = 200,
      -- provider_selector = function(bufnr, filetype, buftype)
      --   return { 'treesitter', 'indent' }
      -- end
    },
    keys = {
      { "zR", function() require("ufo").openAllFolds() end,  desc = "Open all folds" },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
    },
  },
}
