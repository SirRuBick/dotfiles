-- fzf-lua: lazy-loaded on first keymap use
local map = vim.keymap.set

local function load_fzf(cmd)
	return function()
		vim.cmd("packadd fzf-lua")
		local fzf = require("fzf-lua")
		fzf.setup()
		fzf[cmd]()
	end
end

map("n", "<leader>ff", load_fzf("files"), { desc = "Find files" })
map("n", "<leader>fg", load_fzf("live_grep"), { desc = "Live grep" })
map("n", "<leader>fw", load_fzf("live_grep"), { desc = "Find words" })
map("n", "<leader>fb", load_fzf("buffers"), { desc = "Find buffers" })
map("n", "<leader>fo", load_fzf("oldfiles"), { desc = "Recent files" })
map("n", "<leader>fs", load_fzf("grep_cword"), { desc = "Grep word under cursor" })
map("n", "<leader>fk", load_fzf("keymap"), { desc = "Find keymaps" })
map("n", "<leader>fh", load_fzf("helptags"), { desc = "Find help tags" })
