-- Quick Fix 

local opts = { noremap = true, silent = true, buffer = 0 }
vim.keymap.set('n', 'q', '<cmd>cclose<CR>', opts)
