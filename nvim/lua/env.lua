-- Environment detection (OS, shell, paths)
local M = {}

local sysname = vim.loop.os_uname().sysname

M.is_mac = sysname == "Darwin"
M.is_linux = sysname == "Linux"
M.is_windows = sysname == "Windows_NT"
M.is_wsl = vim.fn.has("wsl") == 1
M.is_tmux = vim.env.TMUX ~= nil
M.is_zellij = vim.env.ZELLIJ ~= nil
M.is_ssh = vim.env.SSH_CONNECTION ~= nil or vim.env.SSH_CLIENT ~= nil or vim.env.SSH_TTY ~= nil

M.home = M.is_windows and vim.env.USERPROFILE or vim.env.HOME
M.sep = package.config:sub(1, 1)
M.config_dir = vim.fn.stdpath("config")
M.data_dir = vim.fn.stdpath("data")

return M
