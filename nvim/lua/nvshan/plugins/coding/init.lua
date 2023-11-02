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
      {
        "<leader>xx",
        "<cmd>TroubleToggle<cr>",
        silent = true,
        noremap = true,
        desc =
        "Trouble Toggle"
      },
      {
        "<leader>xw",
        "<cmd>Trouble lsp_workspace_diagnostics<cr>",
        silent = true,
        noremap = true,
        desc =
        "Trouble Workspace Diagnostics"
      },
      {
        "<leader>xd",
        "<cmd>Trouble lsp_document_diagnostics<cr>",
        silent = true,
        noremap = true,
        desc =
        "Trouble Document Diagnostics"
      },
      {
        "<leader>xl",
        "<cmd>Trouble loclist<cr>",
        silent = true,
        noremap = true,
        desc =
        "Trouble Location List"
      },
      {
        "<leader>xq",
        "<cmd>Trouble quickfix<cr>",
        silent = true,
        noremap = true,
        desc =
        "Trouble Quickfix"
      },
      {
        "<leader>gr",
        "<cmd>Trouble lsp_references<cr>",
        silent = true,
        noremap = true,
        desc =
        "Trouble References"
      },
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
    event = "VeryLazy",
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
    event = "VeryLazy",
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
}
