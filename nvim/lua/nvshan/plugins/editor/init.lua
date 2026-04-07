local wk_icons = require("icons").whichkey
local global = require("global")

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
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
    cond = global.is_tmux,
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
      vim.g.tmux_navigator_save_on_switch = 2
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end,
    cmd = {
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
    "swaits/zellij-nav.nvim",
    cond = global.is_zellij,
    event = "VeryLazy",
    keys = {
      { "<c-h>", "<cmd>ZellijNavigateLeftTab<cr>", { silent = true, desc = "navigate left or tab" } },
      { "<c-j>", "<cmd>ZellijNavigateDown<cr>", { silent = true, desc = "navigate down" } },
      { "<c-k>", "<cmd>ZellijNavigateUp<cr>", { silent = true, desc = "navigate up" } },
      { "<c-l>", "<cmd>ZellijNavigateRightTab<cr>", { silent = true, desc = "navigate right or tab" } },
    },
    config = function()
      require("zellij-nav").setup()
      -- NOTE: Ensures that when exiting NeoVim, Zellij returns to normal mode
      -- vim.api.nvim_create_autocmd("VimLeave", {
      --   pattern = "*",
      --   command = "silent !zellij action switch-mode normal",
      -- })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle" },
    config = function()
      require("nvshan.plugins.editor.nvim-tree")
    end,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("nvshan.plugins.editor.project")
    end,
  },
  {
    "olimorris/persisted.nvim",
    cmd = {
      "SessionToggle",
      "SessionStart",
      "SessionStop",
      "SessionLoad",
      "SessionLoadLast",
      "SessionLoadFromFile",
      "SessionDelete",
    },
    config = true,
  },
  {
    "folke/twilight.nvim",
    opts = {
      context = 15, -- amount of lines we will try to show around the current line
    },
    keys = {
      { "<leader>ut", "<cmd>Twilight<CR>", desc = "Toggle twilight" },
    },
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        width = 0.85,
      },
    },
    keys = {
      {
        "<leader>uz",
        function()
          require("zen-mode").toggle()
        end,
        desc = "Toggle zen mode",
      },
    },
  },
  {
    "nvim-pack/nvim-spectre",
    opts = {},
    keys = {
      {
        ",s",
        function()
          require("spectre").toggle()
        end,
        desc = "Toggle Find and Replace",
      },
      {
        ",w",
        function()
          require("spectre").open_visual({ select_word = true })
        end,
        desc = "Search Current Word",
      },
      {
        ",f",
        function()
          require("spectre").open_file_search({ select_word = true })
        end,
        desc = "Search word in current file",
      },
    },
  },
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    opts = {},
    event = { "BufReadPre", "BufNewFile" },
    -- init = function()
    --   vim.g.VM_default_mappings = 0
    --   vim.g.VM_mouse_mappings = 0
    --   vim.g.VM_theme = "iceblue"
    --   vim.g.VM_maps = {
    --     ["Undo"] = "u",
    --     ["Redo"] = "<C-r>",
    --     ["Select All"] = "\\a",
    --     ["Find Under"] = "\\c",
    --     ["Find Subword Under"] = "\\c",
    --     ["Add Cursor Down"] = "\\j",
    --     ["Add Cursor Up"] = "\\k",
    --     ["Add Cursor At Pos"] = "\\m",
    --     ["Start Regex Search"] = "\\/",
    --     ["Reselect Last"] = "\\r",
    --     ["Switch Mode"] = "<Tab>",
    --     ["Visual All"] = "\\A",
    --     ["Visual Regex"] = "\\/",
    --     ["Visual Find"] = "\\f",
    --     ["Visual Cursors"] = "\\c",
    --     ["Visual Add"] = "\\a",
    --     ["Visual Subtract"] = "\\s",
    --     ["Visual Reduce"] = "\\r",
    --   }
    -- end,
  },
  {
    "akinsho/toggleterm.nvim",
    cmd = {
      "ToggleTerm",
      "ToggleTermToggleAll",
      "TermExec",
      "TermSelect",
      "ToggleTermSetName",
      "ToggleTermSendCurrentLine",
      "ToggleTermSendVisualLines",
      "ToggleTermSendVisualSelection",
    },
    opts = {
      open_mapping = [[<c-\>]],
      insert_mappings = true,
      terminal_mappings = true,
    },
    keys = {
      { "<C-\\>", mode = "n", desc = "Toggle terminal" },
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {},
  },
}

return plugins
