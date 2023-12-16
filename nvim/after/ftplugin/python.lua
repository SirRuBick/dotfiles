if vim.fn.exists(":AsyncRun") then
  vim.keymap.set(
    "n",
    "<F4>",
    ":<C-U>AsyncRun python -u "%"<CR>",
    { remap = true, silent = true, buffer = 0 }
  )
end

vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

