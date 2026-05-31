-- Options
local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.wrap = false
opt.scrolloff = 5
opt.sidescrolloff = 10
opt.signcolumn = "yes"
opt.winborder = "rounded"
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.clipboard = "unnamedplus"
opt.pumblend = 10
opt.lazyredraw = true
opt.ttimeoutlen = 50
opt.completeopt = "menu,menuone,noinsert"
opt.swapfile = false
opt.shadafile = "NONE"
opt.mouse = "a"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

opt.fillchars = { eob = " " }

vim.opt.pumborder = "rounded"
vim.opt.pummaxwidth = 60
vim.opt.winborder = "rounded"

-- SSH clipboard via OSC 52
if require("env").is_ssh then
	local function paste()
		return {
			vim.fn.split(vim.fn.getreg(""), "\n"),
			vim.fn.getregtype(""),
		}
	end
	vim.g.clipboard = {
		name = "OSC 52",
		copy = {
			["+"] = require("vim.ui.clipboard.osc52").copy("+"),
			["*"] = require("vim.ui.clipboard.osc52").copy("*"),
		},
		paste = {
			["+"] = paste,
			["*"] = paste,
		},
	}
end
