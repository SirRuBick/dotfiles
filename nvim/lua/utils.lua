-- ### Utilities
--
-- some useful helper functions
--
-- @Author: alex.shan
-- @Date:  2023
--
local Utils = {}
local os_sep = require("global").os_path_sep

--- Concat strings with os separator
---@return string
function Utils.join_path(...)
  local args = { ... }
  local path = table.concat(args, os_sep)
  return path
end

--- Convert a path to a module name
function Utils.path_to_module(path)
  return path.gsub(os_sep, ".")
end

--- Checks whether a given path exists and is a file.
--- @param path (string) path to check
--- @returns (bool)
function Utils.is_file(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "file" or false
end

--- Checks whether a given path exists and is a directory
--- @param path (string) path to check
--- @returns (bool)
function Utils.is_directory(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "directory" or false
end

-- Check if a plugin is available in lazy
function Utils.is_available(plugin)
  local status_ok, lazy = pcall(require, "lazy.core.config")
  return status_ok and lazy.plugins[plugin] ~= nil
end

-- Register which key
function Utils.register_which_key(mode, keymap, opts)
  local registration = {}
  registration[keymap] = opts
  local status_ok, which_key = pcall(require, "which-key")
  if not status_ok then vim.api.nvim_err_writeln("which is not ready to register key bindings") end
  which_key.register(registration, { mode = mode })
end

--- Table based API for setting keybindings
--- @param map_table table A nested table where the first key is the vim mode, the second key is the key to map, and the value is the function to set the mapping to
--- @param base? table A base set of options to set on every keybinding
function Utils.set_mappings(map_table, base)
  -- iterate over the first keys for each mode
  base = base or {}
  for mode, maps in pairs(map_table) do
    -- iterate over each keybinding set in the current mode
    for keymap, options in pairs(maps) do
      -- build the options for the command accordingly
      if options then
        local cmd = options
        local keymap_opts = base
        if type(options) == "table" then
          cmd = options[1]
          keymap_opts = vim.tbl_deep_extend("force", keymap_opts, options)
          keymap_opts[1] = nil
        end
        if not cmd or keymap_opts.name then -- if which-key mapping, queue it
          Utils.register_which_key(mode, keymap, keymap_opts)
        else                                -- if not which-key mapping, set it
          vim.keymap.set(mode, keymap, cmd, keymap_opts)
        end
      end
    end
  end
end

return Utils
