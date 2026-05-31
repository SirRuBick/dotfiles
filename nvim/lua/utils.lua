-- ### Utilities
--
-- some useful helper functions
--
-- @Author: alex.shan
-- @Date:  2023
--
local Utils = {}

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

return Utils

