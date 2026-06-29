-- Minimal bootstrap
local prefix = vim.fn.fnamemodify(vim.v.progpath, ":h:h")
vim.opt.runtimepath:prepend(prefix .. "/lib/nvim")
require('vim._core.ui2').enable({
  enable = true, -- Whether to enable or disable the UI.
})
-- Load plugins first (so colorscheme and plugins are available)
require("plugins")

require("options")
require("theme")
require("keymaps")
require("autocmds")
require("lsp")
require("treesitter")
require("tsutils")
require("statusline")
require("terminal")
