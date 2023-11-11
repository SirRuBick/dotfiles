local utils = {}
local global = require("global")
local join_path = require("utils").join_path

--- class keymap
local keymap = {}

---@return keymap
function keymap:new()
  local instance = {
    rhs = nil,
    options = {
      noremap = true,
      silent = true,
      expr = false,
      nowait = false,
      desc = "",
      buffer = nil,
    },
  }
  setmetatable(instance, self)
  self.__index = self
  return instance
end

--- set keymap rhs
--- @param rhs string|function|nil
function keymap:map(rhs)
  self.rhs = rhs
  return self
end

--- set keymap option noremap
function keymap:noremap()
  self.options.noremap = true
  return self
end

--- set keymap option silent
function keymap:silent()
  self.options.silent = true
  return self
end

--- set keymap option expr
function keymap:expr()
  self.options.expr = true
  return self
end

--- set keymap option nowait
function keymap:nowait()
  self.options.nowait = true
  return self
end

--- set keymap option desc
function keymap:desc(desc_string)
  self.options.desc = desc_string
  return self
end

--- set buffer to do the keymap
function keymap:buffer(buf)
  self.options.buffer = buf
  return self
end

---@param rhs string|function|nil
function utils.map(rhs)
  local km = keymap:new()
  return km:map(rhs)
end

--- set keymap in neovim
--- @param mappings table<string, table<string, keymap>
function utils.load_keymaps(mappings)
  local which_key_queue = {}
  for mode, mapping in pairs(mappings) do
    for lhs, keymap in pairs(mapping) do
      local rhs = keymap.rhs
      local options = keymap.options
      if not rhs then
        -- this is a which key mapping
        if not which_key_queue[mode] then
          which_key_queue[mode] = {}
        end
        which_key_queue[mode][lhs] = options
      else
        -- a normal key map
        vim.keymap.set(mode, lhs, rhs, options)
      end
    end
  end
  utils.which_key_register(which_key_queue)
end

--- Register queued which-key mappings
--- @param which_key_queue table<string, table<string, table<string, string>>>
function utils.which_key_register(which_key_queue)
  local wk_avail, wk = pcall(require, "which-key")
  if wk_avail then
    for mode, registration in pairs(which_key_queue) do
      wk.register(registration, { mode = mode })
    end
  end
end

--- Initialize key map table
function utils.init_mapping()
  local maps = {}
  for _, mode in ipairs { "", "n", "v", "x", "s", "o", "!", "i", "l", "c", "t" } do
    maps[mode] = {}
  end
  if vim.fn.has "nvim-0.10.0" == 1 then
    for _, abbr_mode in ipairs { "ia", "ca", "!a" } do
      maps[abbr_mode] = {}
    end
  end
  return maps
end

--- Merge core keymaps with plugin keymaps
--- @param maps table
--- @param pluginmodule string
function utils.merge_keymap(maps, pluginmodule)
  local searchpath = join_path(global.vim_path, "lua", (pluginmodule:gsub("[.]", global.os_path_sep)))
  local keymap_paths = {}
  local handle = vim.loop.fs_scandir(searchpath)
  while handle do
    local name, t = vim.loop.fs_scandir_next(handle)
    if not name then
      break
    end
    if t == "directory" then
      local full_path = pluginmodule .. "." .. name .. "." .. "keymap"
      table.insert(keymap_paths, full_path)
    end
  end
  for _, source in ipairs(keymap_paths) do
    local status_ok, modmap = pcall(require, source)
    if status_ok then
      maps = vim.tbl_deep_extend("force", maps, modmap)
    end
  end
  return maps
end


return utils
