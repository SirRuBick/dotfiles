-- Bufferline configuration and keymaps
local ok, bufferline = pcall(require, "bufferline")
if not ok then return end

bufferline.setup({})

local map = vim.keymap.set
map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to alternate buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
map("n", "<leader>bf", "<cmd>BufferLinePick<cr>", { desc = "Pick buffer" })
map("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close other buffers" })
map("n", "<leader>bp", "<cmd>BufferLineTogglePin<cr>", { desc = "Toggle pin buffer" })
map("n", "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", { desc = "Close unpinned buffers" })
