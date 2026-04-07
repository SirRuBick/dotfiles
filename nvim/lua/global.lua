local global = {}
local os_name = vim.loop.os_uname().sysname

global.is_mac = os_name == "Darwin"
global.is_linux = os_name == "Linux"
global.is_windows = os_name == "Windows_NT"
global.is_wsl = vim.fn.has("wsl") == 1
global.is_tmux = os.getenv("TMUX") ~= nil
global.is_zellij = os.getenv("ZELLIJ") ~= nil
global.vim_path = vim.fn.stdpath("config")
global.os_path_sep = global.is_windows and "\\" or "/"
global.home = global.is_windows and os.getenv("USERPROFILE") or os.getenv("HOME")
global.cache_dir = global.home .. global.os_path_sep .. ".cache" .. global.os_path_sep .. "nvim" .. global.os_path_sep
global.modules_dir = global.vim_path .. global.os_path_sep .. "modules"
global.data_dir = vim.fn.stdpath("data")

return global
