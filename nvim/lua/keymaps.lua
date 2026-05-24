-- Keymaps
local map = vim.keymap.set
vim.g.mapleader = " "

-- Better j/k for wrapped lines
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Save / Select all / Quit
map({ "i", "n", "v", "s" }, "<C-s>", "<Cmd>w<CR>", { silent = true, desc = "Save file" })
map({ "i", "n" }, "<C-a>", "<Cmd>normal! ggVG<CR>", { silent = true, desc = "Select all" })
map("n", "<leader>qq", "<cmd>wqa<cr>", { desc = "Save all and quit" })

-- Window resize
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Window move
map("n", "<leader>wH", "<C-w>H", { silent = true, desc = "Move window to far left" })
map("n", "<leader>wJ", "<C-w>J", { silent = true, desc = "Move window to bottom" })
map("n", "<leader>wK", "<C-w>K", { silent = true, desc = "Move window to top" })
map("n", "<leader>wL", "<C-w>L", { silent = true, desc = "Move window to far right" })

-- Line movement
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

-- Tabs
map("n", "<leader><tab><tab>", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<CR>", { desc = "Close tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<CR>", { desc = "Close other tabs" })
map("n", "<leader><tab>l", "<cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<leader><tab>h", "<cmd>tabprevious<CR>", { desc = "Previous tab" })

-- Search centered with unfold
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- Flash
map({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash jump" })
map({ "n", "o", "x" }, "S", function() require("flash").treesitter() end, { desc = "Flash treesitter" })
map("o", "r", function() require("flash").remote() end, { desc = "Flash remote" })
map({ "o", "x" }, "R", function() require("flash").treesitter_search() end, { desc = "Flash treesitter search" })
map("c", "<c-s>", function() require("flash").toggle() end, { desc = "Flash toggle search" })
