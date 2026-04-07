-- vim notify
-- quick close notify with q
local opts = { noremap = true, silent = true, buffer = 0 }
vim.keymap.set('n', 'q', '<cmd>q<cr>', opts)
