local plugins = {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "rhysd/accelerated-jk",
    keys = {
      { "j", "<Plug>(accelerated_jk_gj)" },
      { "k", "<Plug>(accelerated_jk_gk)" },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = function()
      require("nvshan.plugins.editor.flash")
    end,
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,     desc = "Remote Flash" },
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc =
        "Treesitter Search"
      },
      {
        "<c-s>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc =
        "Toggle Flash Search"
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
      vim.g.tmux_navigator_save_on_switch = 2
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end,
    commands = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigateNext",
      "TmuxNavigateLast",
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle" },
    -- keys = {
    --   { "<leader>e", "<cmd>NvimTreeToggle<CR>", silent = true, noremap = true, desc = " Explorer" },
    -- },
    config = function()
      require("nvshan.plugins.editor.nvim-tree")
    end,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("nvshan.plugins.editor.project")
    end
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = vim.opt.sessionoptions:get() },
    -- stylua: ignore
    keys = {
      { "<leader>ss", function() require("persistence").load() end,                desc = "Restore Session" },
      { "<leader>sr", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>sq", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
    },
  },
  {
    "folke/twilight.nvim",
    opts = {
      context = 15, -- amount of lines we will try to show around the current line
    },
    keys = {
      { "<leader>ut", "<cmd>Twilight<CR>", desc = "Toggle twilight" }
    },
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        width = .85,
      },
    },
    keys = {
      { "<leader>uz", function() require("zen-mode").toggle() end, desc = "Toggle zen mode" },
    },
  },
  {
    "nvim-pack/nvim-spectre",
    opts = {},
    keys = {
      {
        "<C-f>s",
        function() require("spectre").toggle() end,
        desc =
        "Toggle Find and Replace"
      },
      { "<C-f>w", function() require("spectre").open_visual({ select_word = true }) end, desc = "Search Current Word" },
      {
        "<C-f>f",
        function() require("spectre").open_file_search({ select_word = true }) end,
        desc =
        "Search word in current file"
      },
    },
  },
  {
    "mg979/vim-visual-multi",
    event = { "BufReadPre", "BufNewFile" },
    init = function()
      -- vim.g.VM_default_mappings = 0
      vim.g.VM_maps = {
        ['Select All']         = '\\a',
        ['Find Under']         = '\\c',
        ['Find Subword Under'] = '\\c',
        ['Add Cursor Down']    = '\\j',
        ['Add Cursor Up']      = '\\k',
        ['Add Cursor At Pos']  = '\\m',
        ['Start Regex Search'] = '\\/',
        ['Switch Mode']        = '<Tab>',
        ["Visual Regex"]       = '\\/',
        ["Visual All"]         = '\\a',
        ["Visual Add"]         = '\\n',
        ["Visual Find"]        = '\\f',
        ["Visual Cursors"]     = '\\c',
      }
    end
  },
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    cmd = {
      "ToggleTerm",
      "ToggleTermToggleAll",
      "TermExec",
      "TermSelect",
      "ToggleTermSetName",
      "ToggleTermSendCurrentLine",
      "ToggleTermSendVisualLines",
      "ToggleTermSendVisualSelection"
    },
    opts = {
      open_mapping = [[<c-\>]],
      insert_mappings = true,
      terminal_mappings = true,
    },
  },
}

return plugins
