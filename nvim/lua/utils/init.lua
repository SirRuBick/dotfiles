-- ### Utilities
--
-- some useful helper functions
--
-- @Author: alex.shan
-- @Date:  2023
--
local M = {}

--- Get an icon from `lspkind` if it is available and return it
---@param kind string The kind of icon in `lspkind` to retrieve
---@return string icon
function M.get_icon(kind)
  local icon_pack = vim.g.icons_enabled and "icons" or "text_icons"
  if not M[icon_pack] then
    M.icons = require("icons.nerd_fonts")
    M.text_icons = require "icons.text"
  end
  return M[icon_pack] and M[icon_pack][kind] or ""
end

-- Check if a plugin is available in lazy
function M.is_available(plugin)
  local status_ok, lazy = pcall(require, "lazy.core.config")
  return status_ok and lazy.plugins[plugin] ~= nil
end

-- Register which key
function M.register_which_key(mode, keymap, opts)
  local registration = {}
  registration[keymap] = opts
  local status_ok, which_key = pcall(require, "which-key")
  if not status_ok then vim.api.nvim_err_writeln("which is not ready to register key bindings") end
  which_key.register(registration, { mode = mode })
end

--- Table based API for setting keybindings
--- @param map_table table A nested table where the first key is the vim mode, the second key is the key to map, and the value is the function to set the mapping to
--- @param base? table A base set of options to set on every keybinding
function M.set_mappings(map_table, base)
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
          M.register_which_key(mode, keymap, keymap_opts)
        else -- if not which-key mapping, set it
          vim.keymap.set(mode, keymap, cmd, keymap_opts)
        end
      end
    end
  end
end

return M

