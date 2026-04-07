-- ### Utilities
--
-- some useful helper functions
--
-- @Author: alex.shan
-- @Date:  2023
--
local Utils = {}
local os_sep = require("global").os_path_sep

--- Get filename without extension
---@param path string
---@return string
function Utils.get_filename(path)
  return path:match("^(.+)%.lua$")
end

--- Concat strings with os separator
---@return string
function Utils.join_path(...)
  local args = { ... }
  local path = table.concat(args, os_sep)
  return path
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
  if not status_ok then
    vim.api.nvim_err_writeln("which is not ready to register key bindings")
  end
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
        else -- if not which-key mapping, set it
          vim.keymap.set(mode, keymap, cmd, keymap_opts)
        end
      end
    end
  end
end

--- load lua file returning tables from a directory,
--- and return the tables in a single table by file name
---@param absolute_path string
---@return table
function Utils.load_table_from_dir(absolute_path)
  local merged_table = {}
  local handle = vim.loop.fs_scandir(absolute_path)
  while handle do
    local name, t = vim.loop.fs_scandir_next(handle)
    if not name then
      break
    end
    if name:match(".lua$") and name ~= "init.lua" then
      local filetype = Utils.get_filename(name)
      local status_ok, loaded_snippets = pcall(dofile, Utils.join_path(absolute_path, name))
      if status_ok then
        merged_table[filetype] = loaded_snippets
      else
        vim.notify("Failed to load module for " .. filetype, vim.log.levels.ERROR)
      end
    end
  end
  return merged_table
end

--- Scan a directory and save result to a table
--- @param directory any
---@return table
function Utils.scandir(directory)
  local i, t, popen = 0, {}, io.popen
  local pfile = popen('ls -a "' .. directory .. '"')
  if pfile == nil then return {} end
  for filename in pfile:lines() do
    i = i + 1
    t[i] = filename
  end
  pfile:close()
  return t
end

function Utils.telescope_find_file()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  return coroutine.create(function(coro)
    local opts = {}
    pickers
      .new(opts, {
        prompt_title = "Path to executable",
        finder = finders.new_oneshot_job({ "fd", "--no-ignore", "--type", "x" }, {}),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(buffer_number)
          actions.select_default:replace(function()
            actions.close(buffer_number)
            coroutine.resume(coro, action_state.get_selected_entry()[1])
          end)
          return true
        end,
      })
      :find()
  end)
end

return Utils
