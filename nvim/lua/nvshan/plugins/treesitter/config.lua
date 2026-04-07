local is_wsl = require("global").is_wsl
local is_available = require("utils").is_available
local configs = require("nvim-treesitter.configs")
local lspsaga_loaded, _ = pcall(require, "lspsaga")

---@diagnostic disable-next-line: missing-fields
configs.setup({
  ensure_installed = {
    "bash",
    "c",
    "c_sharp",
    "comment",
    "cpp",
    "css",
    "csv",
    "diff",
    -- "dockerfile",
    "http",
    "html",
    "json",
    "lua",
    "luadoc",
    "luap",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "regex",
    "rust",
    "sql",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "vue",
    "xml",
    "yaml",
  }, -- one of "all" or a list of languages
  auto_install = true,
  ignore_install = { "phpdoc" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
  incremental_selection = {
    enable = not is_available("wildfire.nvim"),
    keymaps = {
      init_selection = "<CR>", -- set to `false` to disable one of the mappings
      node_incremental = "<CR>",
      scope_incremental = false,
      node_decremental = "<BS>",
    },
  },
  -- Extra plugins
  textobjects = {
    -- text object select
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can optionally set descriptions to the mappings (used in the desc parameter of
        -- nvim_buf_set_keymap) which plugins like which-key display

        -- select function
        ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
        ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },
        -- select language scope
        ["as"] = { query = "@scope.outer", query_group = "locals", desc = "Select language scope" },
        ["is"] = { query = "@scope.inner", query_group = "locals", desc = "Select inner language scope" },
        --select class
        ["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        -- select assignments
        ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
        ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
        ["l="] = { query = "@assignment.lhs", desc = "Select left hand side part of an assignment" },
        ["r="] = {
          query = "@assignment.rhs",
          desc = "Select right hand include_surrounding_whitespace part of an assignment",
        },
        -- select function parameter
        ["aa"] = { query = "@parameter.outer", desc = "Select outer part of an parameter/argument" },
        ["ia"] = { query = "@parameter.inner", desc = "Select inner part of an parameter/argument" },
        -- select conditional
        ["ai"] = { query = "@conditional.outer", desc = "Select outer part of an conditional" },
        ["ii"] = { query = "@conditional.inner", desc = "Select inner part of an conditional" },
        -- select loop
        ["al"] = { query = "@loop.outer", desc = "Select outer part of an loop" },
        ["il"] = { query = "@loop.inner", desc = "Select inner part of an loop" },
        -- select function call
        ["af"] = { query = "@call.outer", desc = "Select outer part of an function call" },
        ["if"] = { query = "@call.inner", desc = "Select inner part of an function call" },
      },
      -- You can choose the select mode (default is charwise "v")
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg "@function.inner"
      -- * method: eg "v" or "o"
      -- and should return the mode ("v", "V", or "<c-v>") or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ["@parameter.outer"] = "v", -- charwise
        ["@function.outer"] = "V", -- linewise
        ["@class.outer"] = function() -- blockwise
          if is_wsl then
            return "<c-q>"
          end
          return "<c-v>"
        end,
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg "@function.inner"
      -- * selection_mode: eg "v"
      -- and should return true of false
      include_surrounding_whitespace = false,
    },
    -- text object swap
    swap = {
      enable = true,
      swap_next = {
        ["]."] = "@parameter.inner", -- swap parameter/argument with next
        ["],"] = "@function.outer", -- swap method/function with next
      },
      swap_previous = {
        ["[."] = "@parameter.inner", -- swap parameter/argument with previous
        ["[,"] = "@function.outer", -- swap method/function with previous
      },
    },
    -- text object move
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]f"] = { query = "@call.outer", desc = "Next function call start" },
        ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
        ["]c"] = { query = "@class.outer", desc = "Next class start" },
        ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
        ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
        ["]a"] = { query = "@parameter.inner", desc = "Next parameter start" },
      },
      goto_next_end = {
        ["]F"] = { query = "@call.outer", desc = "Next function call end" },
        ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
        ["]C"] = { query = "@class.outer", desc = "Next class end" },
        ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
        ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
      },
      goto_previous_start = {
        ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
        ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
        ["[c"] = { query = "@class.outer", desc = "Prev class start" },
        ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
        ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
        ["[a"] = { query = "@parameter.inner", desc = "Prev parameter start" },
      },
      goto_previous_end = {
        ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
        ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
        ["[C"] = { query = "@class.outer", desc = "Prev class end" },
        ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
        ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
      },
    },
    lsp_interop = {
      enable = not lspsaga_loaded,
      border = "none",
      floating_preview_opts = {},
      peek_definition_code = {
        ["<leader>lp"] = { query = "@function.outer", desc = "Peek function definition" },
        ["<leader>lP"] = { query = "@class.outer", desc = "Peek class definition" },
      },
    },
  },
  rainbow = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  autopairs = {
    enable = true,
  },
})

-- nvim-treesitter-textobjects
local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
-- vim way: ; goes to the direction you were moving.
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
vim.keymap.set({ "n", "x", "o" }, "'", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

-- Optionally, make gitsigns.nvim movement repeatable with ; and ,
local status_ok, gs = pcall(require, "gitsigns")
-- make sure forward function comes first
local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
-- Or, use `make_repeatable_move` or `set_last_move` functions for more control. See the code for instructions.
vim.keymap.set({ "n", "x", "o" }, "]h", next_hunk_repeat)
vim.keymap.set({ "n", "x", "o" }, "[h", prev_hunk_repeat)

-- nvim-treesitter-context
local status_ok, ts_context = pcall(require, "treesitter-context")
if not status_ok then
  vim.notify("Missing nvim-treesitter-context dependency", vim.log.levels.WARN)
  return
end

ts_context.setup({
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 10, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 5, -- Maximum number of lines to show for a single context
  trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: "inner", "outer"
  mode = "cursor", -- Line used to calculate context. Choices: "cursor", "topline"
  -- Separator between context and content. Should be a single character string, like "-".
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
})
