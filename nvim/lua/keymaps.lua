-- Keymaps
local map = vim.keymap.set

-- Icons
local wk_icons = require("icons").whichkey
local utils = require("utils")

-- Window split
map("n", "<leader>wh", "<cmd>leftabove vsplit<cr>", { desc = "Split left and focus" })
map("n", "<leader>wj", "<cmd>rightbelow split<cr>", { desc = "Split below and focus" })
map("n", "<leader>wk", "<cmd>leftabove split<cr>", { desc = "Split above and focus" })
map("n", "<leader>wl", "<cmd>rightbelow vsplit<cr>", { desc = "Split right and focus" })

-- Window move to far
map("n", "<leader>wH", "<C-w>H", { desc = "Move window to far left" })
map("n", "<leader>wJ", "<C-w>J", { desc = "Move window to far bottom" })
map("n", "<leader>wK", "<C-w>K", { desc = "Move window to far top" })
map("n", "<leader>wL", "<C-w>L", { desc = "Move window to far right" })

-- Window management
map("n", "<leader>ww", "<C-w>w", { desc = "Switch to next window" })
map("n", "<leader>wp", "<C-w>p", { desc = "Switch to previous window" })
map("n", "<leader>ws", "<C-w>x", { desc = "Exchange window with next" })
map("n", "<leader>we", "<C-w>=", { desc = "Equalize window sizes" })
map("n", "<leader>wo", "<cmd>only<cr>", { desc = "Close other windows" })
map("n", "<leader>wq", "<cmd>quit<cr>", { desc = "Close current window" })
map("n", "<leader>wz", function()
	local cur = vim.api.nvim_get_current_win()
	if _win_tabzoom then
		if vim.api.nvim_win_is_valid(_win_tabzoom) then
			vim.api.nvim_set_current_win(_win_tabzoom)
			vim.cmd("tabclose")
		end
		_win_tabzoom = nil
	else
		_win_tabzoom = cur
		vim.cmd("tab split")
	end
end, { desc = "Toggle zoom window" })

-- Window resize
map("n", "<leader>w+", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<leader>w-", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<leader>w>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
map("n", "<leader>w<", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })

-- Better j/k for wrapped lines
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Save / Select all / Quit
map({ "i", "n", "v", "s" }, "<C-s>", "<Cmd>w<CR>", { silent = true, desc = "Save file" })
map({ "i", "n" }, "<C-a>", "<Cmd>normal! ggVG<CR>", { silent = true, desc = "Select all" })
map("n", "<leader>q", "<cmd>wqa<cr>", { desc = "Save & Quit" })

-- Window resize
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Line movement
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

-- Buffer management
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<leader>bb", "<cmd>b#<cr>", { desc = "Switch to alternate buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
map("n", "<leader>bo", function()
	local cur = vim.api.nvim_get_current_buf()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if buf ~= cur and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
			pcall(vim.api.nvim_buf_delete, buf, {})
		end
	end
end, { desc = "Close other buffers" })

-- Search centered with unfold
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- Reload config
map("n", "<leader>or", "<cmd>source $MYVIMRC<cr>", { desc = "Reload config" })

-- Undotree
vim.cmd("packadd nvim.undotree")
map("n", "<leader>u", "<cmd>Undotree<cr>", { desc = "UndoTree" })

-- Paste without overwriting clipboard
map("x", "p", '"_dP', { desc = "Paste without yanking" })

-- Swap visual selection with clipboard
map("x", "P", function()
	-- vim.cmd('normal! "+ygv"_d"+P')
    local clip = vim.fn.getreg("+")
    local cliptype = vim.fn.getregtype("+")
    if clip == "" then return end

    local zsave = vim.fn.getreg("z")
    local zsavetype = vim.fn.getregtype("z")

    vim.cmd('normal! "zy')
    local sel = vim.fn.getreg("z")
    local seltype = vim.fn.getregtype("z")

    vim.fn.setreg("z", clip, cliptype)
    vim.cmd('normal! gv"_d"zP')

    vim.fn.setreg("z", zsave, zsavetype)

    vim.fn.setreg("+", sel, seltype)
    vim.fn.setreg("", sel, seltype)
end, { desc = "Swap selection with clipboard" })

-- Indent with Tab / Unindent with Shift-Tab
map("n", "<Tab>", ">>", { desc = "Indent line" })
map("n", "<S-Tab>", "<<", { desc = "Unindent line" })
map("v", "<Tab>", ">gv", { desc = "Indent selection" })
map("v", "<S-Tab>", "<gv", { desc = "Unindent selection" })

-- Flash
map({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "Flash jump" })
map({ "n", "o", "x" }, "S", function()
	require("flash").treesitter()
end, { desc = "Flash treesitter" })
map("o", "r", function()
	require("flash").remote()
end, { desc = "Flash remote" })
map({ "o", "x" }, "R", function()
	require("flash").treesitter_search()
end, { desc = "Flash treesitter search" })
map("c", "<c-s>", function()
	require("flash").toggle()
end, { desc = "Flash toggle search" })

-- Incremental selection via built-in treesitter/LSP (Neovim 0.12+)
map({ "n", "x" }, "<CR>", function()
	local count = vim.v.count1
	if vim.treesitter.get_parser(nil, nil, { error = false }) then
		require("vim.treesitter._select").select_parent(count)
	else
		pcall(vim.lsp.buf.selection_range, count)
	end
end, { desc = "Select parent node" })

map("x", "<BS>", function()
	local count = vim.v.count1
	if vim.treesitter.get_parser(nil, nil, { error = false }) then
		require("vim.treesitter._select").select_child(count)
	else
		pcall(vim.lsp.buf.selection_range, -count)
	end
end, { desc = "Select child node" })

-- Better j/k for wrapped lines
