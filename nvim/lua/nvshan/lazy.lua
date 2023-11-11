local globals = require("global")
local settings = require("settings")
local join_path = require("utils").join_path

local rootpath = join_path(globals.data_dir, "lazy")
local lazypath = join_path(rootpath, "lazy.nvim")
local lockpath = join_path(globals.vim_path, "lazy-lock.json")

if not vim.loop.fs_stat(lazypath) then
  local output = vim.fn.system({
    "git",
    "clone",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  })
  if vim.api.nvim_get_vvar("shell_error") ~= 0 then
    vim.api.nvim_err_writeln("Error cloning lazy.nvim repository...\n\n" .. output)
  end
end
if not vim.tbl_contains(vim.opt.rtp:get(), lazypath) then
  vim.opt.rtp:prepend(lazypath)
end


local lazyconfig = {
  root = rootpath, -- directory where plugins will be installed
  defaults = {
    lazy = true,   -- should plugins be lazy-loaded?
    version = nil,
    -- default `cond` you can use to globally disable a lot of plugins
    -- when running inside vscode for example
    cond = nil, ---@type boolean|fun(self:LazyPlugin):boolean|nil
    -- version = "*", -- enable this to try installing the latest stable versions of plugins
  },
  lockfile = lockpath, -- lockfile generated after running update.
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { settings.colorscheme },
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true,        -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[]
      paths = {},          -- add any custom paths here that you want to includes in the rtp
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {
        -- "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        -- "tarPlugin",
        -- "tohtml",
        -- "tutor",
        -- "zipPlugin",
      },
    },
  },
}

require("lazy").setup(settings.pluginmodule, lazyconfig)
