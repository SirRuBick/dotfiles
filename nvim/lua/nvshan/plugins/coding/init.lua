return {
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("nvshan.plugins.coding.Comment")
    end,
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "Comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
    },
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
    config = function()
      require("nvshan.plugins.coding.trouble")
    end,
  },
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvshan.plugins.coding.illuminate")
    end,
  },
  {
    "SUSTech-data/wildfire.nvim",
    event = { "BufRead", "BufNewFile" },
    -- dependencies = { "nvim-treesitter/nvim-treesitter" },
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
        visual = "s",
        visual_line = "S",
        delete = "ds",
        change = "cs",
        change_line = "cS",
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
  },
  {
    "kevinhwang91/nvim-ufo",
    cmd = {
      "UfoEnable",
      "UfoDisable",
      "UfoInspect",
      "UfoAttach",
      "UfoDetach",
      "UfoEnableFold",
      "UfoDisableFold",
    },
    dependencies = {
      "kevinhwang91/promise-async",
    },
    opts = {
      open_fold_hl_timeout = 200,
      -- provider_selector = function(bufnr, filetype, buftype)
      --   return { 'treesitter', 'indent' }
      -- end
    },
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "Open all folds",
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
        desc = "Close all folds",
      },
    },
  },
  {
    "Wansmer/treesj",
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    -- dependencies = { "nvim-tressitter/nvim-treesitter" },
    config = function()
      require("nvshan.plugins.coding.treesj")
    end,
    keys = {
      {
        "<leader>cs",
        function()
          require("treesj").toggle()
        end,
        desc = "Split/Join Toggle",
      },
      {
        "<leader>cS",
        function()
          require("treesj").toggle({ split = { recursive = true } })
        end,
        desc = "Split/Join Toggle Recursively",
      },
    },
  },
}
