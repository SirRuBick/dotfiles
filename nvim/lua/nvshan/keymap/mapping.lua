local keymap_utils = require("nvshan.keymap.utils")
local mappings = keymap_utils.init_mapping()
local map = keymap_utils.map

-- which key descriptions
local wk_icons = require("icons").whichkey
mappings.n["<leader>f"] = map():desc(wk_icons.f)
mappings.n["<leader>p"] = map():desc(wk_icons.p)
mappings.n["<leader>l"] = map():desc(wk_icons.l)
mappings.n["<leader>u"] = map():desc(wk_icons.u)
mappings.n["<leader>b"] = map():desc(wk_icons.b)
mappings.n["<leader>d"] = map():desc(wk_icons.d)
mappings.n["<leader>g"] = map():desc(wk_icons.g)
mappings.n["<leader>t"] = map():desc(wk_icons.t)
mappings.n["<leader>s"] = map():desc(wk_icons.s)

-- Insert --
mappings.i["jk"] = map("<ESC>"):desc("Exit")
mappings.i["<C-s>"] = map("<ESC><cmd>w<CR>"):desc("Save file")

-- Normal --
mappings.n["<C-s>"] = map("<cmd>w<CR>"):desc("Save file")
if not require("configs.global").is_wsl then
    -- <C-Q> for vitual block mode under windows
    mappings.n["<C-q>"] = map("<cmd>q<CR>"):desc("Quit")
end

-- Split Navigation
mappings.n["<C-h>"] = map("<C-w>h"):silent():noremap():desc("Move to left split")
mappings.n["<C-j>"] = map("<C-w>j"):silent():noremap():desc("Move to below split")
mappings.n["<C-k>"] = map("<C-w>k"):silent():noremap():desc("Move to above split")
mappings.n["<C-l>"] = map("<C-w>l"):silent():noremap():desc("Move to right split")

mappings.n["<C-Up>"] = map("<cmd>resize -2<CR>"):desc("Resize split up")
mappings.n["<C-Down>"] = map("<cmd>resize +2<CR>"):desc("Resize split down")
mappings.n["<C-Left>"] = map("<cmd>vertical resize -2<CR>"):desc("Resize split left")
mappings.n["<C-Right>"] = map("<cmd>vertical resize +2<CR>"):desc("Resize split right")
-- Improved Terminal Navigation
mappings.n["<C-h>"] = map(":wincmd h<CR>"):desc("Move to left split")
mappings.n["<C-j>"] = map(":wincmd j<CR>"):desc("Move to below split")
mappings.n["<C-k>"] = map(":wincmd k<CR>"):desc("Move to above split")
mappings.n["<C-l>"] = map(":wincmd l<CR>"):desc("Move to right split")

mappings.n["<S-h>"] = map("<cmd>bprevious<CR>"):desc("Prev buffer")
mappings.n["<S-l>"] = map("<cmd>bnext<CR>"):desc("Next buffer")
mappings.n["[b"] = map("<cmd>bprevious<CR>"):desc("Prev buffer")
mappings.n["]b"] = map("<cmd>bnext<CR>"):desc("Next buffer")
mappings.n["<leader>bb"] = map(":buffers<CR>:buffer<Space>"):desc("Switch to buffer by name")
mappings.n["<leader>bd"] = map(":bd<CR>"):desc("Delete buffer")

-- Visual --
-- Move text up and down
mappings.v["<A-j>"] = map(":m .+1<CR>=="):desc("move text up")
mappings.v["<A-k>"] = map(":m .-2<CR>=="):desc("move text down")
mappings.x["J"] = map(":move '>+1<CR>gv-gv"):desc("move text up")
mappings.x["K"] = map(":move '<-2<CR>gv-gv"):desc("move text down")
mappings.x["<A-j>"] = map(":move '>+1<CR>gv-gv"):desc("move text up")
mappings.x["<A-k>"] = map(":move '<-2<CR>gv-gv"):desc("move text down")
-- Stay in indent mode
mappings.v["<A-[>"] = map("<gv"):desc("unindent line")
mappings.v["<A-]>"] = map(">gv"):desc("indent line")

-- Plugin Manager
mappings.n["<leader>pi"] = map(require("lazy").install):expr():desc("Plugins Install")
mappings.n["<leader>ps"] = map(require("lazy").home):desc("Plugins Status")
mappings.n["<leader>pS"] = map(require("lazy").sync):desc("Plugins Sync")
mappings.n["<leader>pu"] = map(require("lazy").check):desc("Plugins Check Updates")
mappings.n["<leader>pU"] = map(require("lazy").update):desc("Plugins Update")


return mappings
