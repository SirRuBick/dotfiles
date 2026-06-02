-- Oil file explorer
local wk_icons = require("icons").whichkey
local ok, oil = pcall(require, "oil")
if not ok then
	return
end

oil.setup({
	keymaps = {
		["q"] = { "actions.close", mode = "n" },
	},
	float = {
		-- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
		max_width = 0.9,
		max_height = 0.9,
	},
})

vim.keymap.set("n", "<leader>e", function()
	if vim.bo.filetype == "oil" then
		oil.close()
	else
		oil.open_float()
	end
end)
