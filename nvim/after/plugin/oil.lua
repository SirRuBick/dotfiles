-- Oil file explorer: lazy-loaded on first use
local wk_icons = require("icons").whichkey

local oil_loaded = false
local oil

local function load_oil()
	if not oil_loaded then
		vim.cmd("packadd oil.nvim")
		oil = require("oil")
		oil.setup({
			keymaps = {
				["q"] = { "actions.close", mode = "n" },
			},
			float = {
				max_width = 0.9,
				max_height = 0.9,
			},
			view_options = {
				show_hidden = true,
			},
		})
		oil_loaded = true
	end
end

vim.keymap.set("n", "<leader>e", function()
	load_oil()
	if vim.bo.filetype == "oil" then
		oil.close()
	else
		oil.open_float()
	end
end, { desc = wk_icons.e.group })
