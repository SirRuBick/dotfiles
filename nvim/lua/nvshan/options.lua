-- ### vim options
--
-- Some basic options, refer to :help options
--
-- @Author: alex shan
-- @Date:   2023
--
local settings = require("settings")
local global_settings = require("global")
local option = vim.opt
local buffer = vim.b
local global = vim.g

-- ui
option.termguicolors = true
option.showmode = false
option.number = true
option.relativenumber = true
option.cursorline = true
option.cmdheight = 2 -- more space in command line
option.signcolumn = "yes"
option.scrolloff = 5
option.laststatus = 3
option.title = true
option.winblend = 10 -- transparent window
-- search
option.hlsearch = true
option.ignorecase = true
-- tabs
option.expandtab = true
option.shiftwidth = 2
option.tabstop = 2
option.autoindent = true
option.shiftround = true
option.smartindent = true
-- operations
option.backup = false
option.swapfile = false
option.mouse = nil      -- disable mouse
option.clipboard = "unnamedplus" -- allows neovim to access system clipboard
option.undofile = true  -- enable persistent undo
option.updatetime = 300 -- faster completion (default 4000ms)
option.timeoutlen = 300
option.completeopt = { "menuone", "noselect" }
option.splitbelow = true
option.splitright = true
option.wrap = false
option.exrc = true
-- foldcolumn
option.foldlevel = 99
option.foldmethod = "expr"
option.foldexpr = "nvim_treesitter#foldexpr()"

-- buffer
buffer.fileencoding = "utf-8"

-- global
global.mapleader = settings.leader
global.maplocalleader = ""
global.highlighturl_enabled = true
global.icons_enabled = true

if global_settings.is_wsl then
  global.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
    paste = {
      ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end
