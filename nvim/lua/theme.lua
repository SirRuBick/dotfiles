-- Theme
vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.cmd([[colorscheme catppuccin]])

-- Transparency toggle
vim.g.transparent_enabled = true

local function apply_transparency()
	if vim.g.transparent_enabled then
		vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
	end
end

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = apply_transparency,
	desc = "Apply transparency on colorscheme change",
})

apply_transparency()

vim.keymap.set("n", "<leader>ob", function()
	vim.g.transparent_enabled = not vim.g.transparent_enabled
	apply_transparency()
	vim.notify("Transparency " .. (vim.g.transparent_enabled and "on" or "off"))
end, { desc = "Toggle transparency" })
