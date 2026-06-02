-- fzf-lua configuration and keymaps
local ok, fzf = pcall(require, "fzf-lua")
if not ok then
	return
end

fzf.setup()

local map = vim.keymap.set

-- File finder
map("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fw", "<cmd>FzfLua live_grep<cr>", { desc = "Find words" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Find buffers" })
map("n", "<leader>fo", "<cmd>FzfLua oldfiles<cr>", { desc = "Recent files" })
map("n", "<leader>fs", "<cmd>FzfLua grep_cword<cr>", { desc = "Grep word under cursor" })
map("n", "<leader>fk", "<cmd>FzfLua keymap<cr>", { desc = "Find keymaps" })
map("n", "<leader>fh", "<cmd>FzfLua helptags<cr>", { desc = "Find help tags" })
