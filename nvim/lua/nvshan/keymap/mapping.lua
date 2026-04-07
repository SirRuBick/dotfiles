local global = require("global")
local custom_functions = require("nvshan.functions")
local keymap_utils = require("nvshan.keymap.utils")
local mappings = keymap_utils.init_mapping()
local map = keymap_utils.map

local is_available = require("utils").is_available

-- which key descriptions
local wk_icons = require("icons").whichkey
mappings.n["<leader>b"] = map():desc(wk_icons.b)
mappings.n["<leader>c"] = map():desc(wk_icons.c)
mappings.n["<leader>f"] = map():desc(wk_icons.f)
mappings.n["<leader>g"] = map():desc(wk_icons.g)
mappings.n["<leader>q"] = map():desc(wk_icons.q)
mappings.n["<leader>s"] = map():desc(wk_icons.s)
mappings.n["<leader>t"] = map():desc(wk_icons.t)
mappings.n["<leader>u"] = map():desc(wk_icons.u)
mappings.n["<leader>w"] = map():desc(wk_icons.w)
mappings.n["<leader>x"] = map():desc(wk_icons.x)

-- Operations
mappings.t["<C-g>"] = map("<C-\\><C-n>"):silent():desc("Exit terminal mode")
mappings.i["jk"] = map("<C-\\><C-n>"):desc("Exit insert mode")

-- navigate in insert mode
mappings.i["<C-h>"] = map("<Left>"):desc("Move left")
mappings.i["<C-l>"] = map("<Right>"):desc("Move right")
mappings.i["<C-j>"] = map("<Down>"):desc("Move down")
mappings.i["<C-k>"] = map("<Up>"):desc("Move up")
mappings.i["<C-b>"] = map("<Home>"):desc("Move to line begin")
mappings.i["<C-e>"] = map("<End>"):desc("Move to line end")

-- Operations
mappings.n["<ESC>"] = map("<Esc><CMD>noh<CR>"):desc("Clear Highlights")

-- Coding enhancement
mappings.n["<A-o>"] = map("o<Esc>k"):desc("New Line below")
mappings.n["<A-O>"] = map("O<Esc>j"):desc("New Line above")
mappings.n["<A-j>"] = map(":m .+1<CR>=="):desc("move text up")
mappings.n["<A-k>"] = map(":m .-2<CR>=="):desc("move text down")

-- Moves
mappings.n["<M-m>"] = map("col('.')==1?'$':'0'"):expr():desc("Jump to line start or end")
mappings.v["<M-m>"] = map("col('.')==1?'$h':'0'"):expr():desc("Jump to line start or end")
mappings.n["<M-n>"] = map("col('.')==match(getline('.'),'\\S')+1?'$':'^'"):expr():desc("Jump to line start or end")
mappings.v["<M-n>"] = map("col('.')==match(getline('.'),'\\S')+1?'$h':'^'"):expr():desc("Jump to line start or end")
mappings.n["<A-h>"] = map("^"):silent():desc("Go to line begin")
mappings.n["<A-l>"] = map("$"):silent():desc("Go to line end")
mappings.v["<A-h>"] = map("^"):silent():desc("Go to line begin")
mappings.v["<A-l>"] = map("$"):silent():desc("Go to line end")
mappings.i["<A-h>"] = map("<HOME>"):desc("Move to line begin")
mappings.i["<A-l>"] = map("<END>"):desc("Move to line end")
mappings.c["<A-h>"] = map("<HOME>"):desc("Move to command begin")
mappings.c["<A-l>"] = map("<END>"):desc("Move to command end")
mappings.o["<A-l>"] = map("$"):silent():desc("Line end")
mappings.o["<A-h>"] = map("^"):silent():desc("Line begin")
mappings.n["[q"] = map("<cmd>cprevious<CR>"):silent():desc("Prev quickfix")
mappings.n["]q"] = map("<cmd>cnext<CR>"):silent():desc("Next quickfix")
mappings.n["[Q"] = map("<cmd>cfirst<CR>"):silent():desc("First quickfix")
mappings.n["]Q"] = map("<cmd>clast<CR>"):silent():desc("Last quickfix")
mappings.n["[o"] = map("<cmd>lprevious<CR>"):silent():desc("Prev location")
mappings.n["]o"] = map("<cmd>lnext<CR>"):silent():desc("Next location")
mappings.n["[O"] = map("<cmd>lfirst<CR>"):silent():desc("First location")
mappings.n["]O"] = map("<cmd>llast<CR>"):silent():desc("Last location")
-- close qf or ll if they are present, see https://superuser.com/questions/355325/close-all-locations-list-or-quick-fix-windows-in-vim
mappings.n["QC"] = map(":ccl <bar> lcl<CR>"):desc("Quick close quickfix or locationlist")

-- Folding
mappings.n["zc"] = map("zc"):desc("zMzv"):desc("Focus on Fold")

-- Search
mappings.n["n"] = map("nzz"):silent():desc("Next Search Result")
mappings.n["N"] = map("Nzz"):silent():desc("Prev Search Result")

-- Macro TODO: Test
mappings.n["'q"] = map("q"):noremap():desc("Record Macro")
mappings.n["'r"] = map("@"):noremap():desc("Excute Macro")
mappings.n["q"] = map(""):noremap():desc("Disable Default Macro Prefix")

-- Split Navigation
mappings.n["<leader>k"] = map("<cmd>only<CR>"):silent():noremap():desc(wk_icons.k)
mappings.n["<C-h>"] = map("<C-w>h"):silent():noremap():desc("Move to left split")
mappings.n["<C-j>"] = map("<C-w>j"):silent():noremap():desc("Move to below split")
mappings.n["<C-k>"] = map("<C-w>k"):silent():noremap():desc("Move to above split")
mappings.n["<C-l>"] = map("<C-w>l"):silent():noremap():desc("Move to right split")
-- mappings.t["<C-h>"] = map("<C-\\><C-n>:wincmd h<CR>"):silent():noremap():desc("Move to left split")
-- mappings.t["<C-j>"] = map("<C-\\><C-n>:wincmd j<CR>"):silent():noremap():desc("Move to below split")
-- mappings.t["<C-k>"] = map("<C-\\><C-n>:wincmd k<CR>"):silent():noremap():desc("Move to above split")
-- mappings.t["<C-l>"] = map("<C-\\><C-n>:wincmd l<CR>"):silent():noremap():desc("Move to right split")

mappings.n["<M-Up>"] = map("<cmd>resize -2<CR>"):desc("Resize split up")
mappings.n["<M-Down>"] = map("<cmd>resize +2<CR>"):desc("Resize split down")
mappings.n["<M-Left>"] = map("<cmd>vertical resize -2<CR>"):desc("Resize split left")
mappings.n["<M-Right>"] = map("<cmd>vertical resize +2<CR>"):desc("Resize split right")

mappings.n["<leader>wh"] = map("<cmd>set nosplitright<CR><CMD>vsplit<CR><CMD>set splitright<CR>"):desc("Split left")
mappings.n["<leader>wj"] = map("<cmd>set nosplitbelow<CR><CMD>split<CR><CMD>set splitbelow<CR>"):desc("Split above")
mappings.n["<leader>wk"] = map("<cmd>set splitbelow<CR><CMD>split<CR>"):desc("Split below")
mappings.n["<leader>wl"] = map("<cmd>set splitright<CR><CMD>vsplit<CR>"):desc("Split right")
mappings.n["<leader>wH"] = map("<C-w>H"):desc("Move window to left")
mappings.n["<leader>wJ"] = map("<C-w>J"):desc("Move window to bottom")
mappings.n["<leader>wK"] = map("<C-w>K"):desc("Move window to top")
mappings.n["<leader>wL"] = map("<C-w>L"):desc("Move window to right")
mappings.n["<leader>w-"] = map("<C-w>-"):desc("Max height")
mappings.n["<leader>w|"] = map("<C-w>|"):desc("Max width")
mappings.n["<leader>w="] = map("<C-w>="):desc("Normalize windows")
mappings.n["<leader>wq"] = map("<C-w>q"):desc("Quit window")
mappings.n["<leader>wo"] = map("<C-w>q"):desc("Close other windows")
mappings.n["<leader>wr"] = map("<C-w>r"):desc("Rotate window")
mappings.n["<leader>wR"] = map("<C-w>r"):desc("Rotate window")
mappings.n["<leader>wt"] = map("<cmd>tab split<CR>"):desc("New Tab")
mappings.n["<leader>wT"] = map("<C-w>T"):desc("Open curr window in new tab")
mappings.n["<leader>wm"] = map(custom_functions.toggle_maxwin):desc("Toggle max window")
mappings.n["[t"] = map("<cmd>tabprevious<CR>"):desc("Prev tab")
mappings.n["]t"] = map("<cmd>tabnext<CR>"):desc("Next tab")

-- Improved Terminal Navigation
mappings.n["<C-h>"] = map(":wincmd h<CR>"):desc("Move to left split")
mappings.n["<C-j>"] = map(":wincmd j<CR>"):desc("Move to below split")
mappings.n["<C-k>"] = map(":wincmd k<CR>"):desc("Move to above split")
mappings.n["<C-l>"] = map(":wincmd l<CR>"):desc("Move to right split")

-- Buffer
mappings.n["[b"] = map("<cmd>bprevious<CR>"):desc("Prev buffer")
mappings.n["]b"] = map("<cmd>bnext<CR>"):desc("Next buffer")
mappings.n["[B"] = map("<cmd>bfirst<CR>"):desc("First buffer")
mappings.n["]B"] = map("<cmd>blast<CR>"):desc("Last buffer")
mappings.n["<leader>br"] = map("<cmd>:e<cr>"):desc("Refresh buffer")
mappings.n["<leader>bd"] = map(":bd<CR>"):desc("Delete buffer")
mappings.n["<leader>bn"] = map(":new<CR>"):desc("New buffer")
mappings.n["<leader>bw"] = map("<cmd>w<CR>"):desc("Save current buffer")
mappings.n["<leader>bs"] = map("<cmd>wa<CR>"):desc("Save all buffer")
mappings.n["<leader>bq"] = map("<cmd>q<CR>"):desc("Quit buffer")
mappings.n["<leader>bQ"] = map("<cmd>qa<CR>"):desc("Quit all buffer")
if is_available("bufferline.nvim") then
  mappings.n["[b"] = map("<cmd>BufferLineCyclePrev<CR>"):desc("Prev buffer")
  mappings.n["]b"] = map("<cmd>BufferLineCycleNext<CR>"):desc("Next buffer")
  mappings.n["[B"] = map(function()
    require("bufferline").go_to(1, true)
  end):desc("First buffer")
  mappings.n["]B"] = map(function()
    require("bufferline").go_to(-1, true)
  end):desc("Last buffer")
  mappings.n["<leader>b["] = map("<cmd>BufferLineMovePrev<CR>"):desc("Move buffer backwards")
  mappings.n["<leader>b]"] = map("<cmd>BufferLineMoveNext<CR>"):desc("Move buffer forwards")
  mappings.n["<leader>bg"] = map("<cmd>BufferLineGroupToggle<CR>"):desc("Bufferline group toggle")
  mappings.n["<leader>bG"] = map("<cmd>BufferLineGroupClose<CR>"):desc("Bufferline group close")
  mappings.n["<leader>bp"] = map("<cmd>BufferLinePick<CR>"):desc("Bufferline pick")
  mappings.n["<leader>bc"] = map("<cmd>BufferLineClose<CR>"):desc("Bufferline pick to close")
  mappings.n["<leader>bo"] = map("<cmd>BufferLineCloseOthers<CR>"):desc("Close all other buffers")
  mappings.n["<leader>bl"] = map("<cmd>BufferLineTogglePin<CR>"):desc("Lock(Pin) buffer")
  for idx = 1, 9 do
    mappings.n["<leader>b" .. idx] = map(function()
      require("bufferline").go_to(idx, true)
    end):desc("Bufferline go to buffer " .. idx)
  end
end

-- Move text up and down
mappings.v["<A-j>"] = map(":m .+1<CR>=="):desc("move text up")
mappings.v["<A-k>"] = map(":m .-2<CR>=="):desc("move text down")
mappings.x["J"] = map(":move '>+1<CR>gv-gv"):desc("move text up")
mappings.x["K"] = map(":move '<-2<CR>gv-gv"):desc("move text down")
mappings.x["<A-j>"] = map(":move '>+1<CR>gv-gv"):desc("move text up")
mappings.x["<A-k>"] = map(":move '<-2<CR>gv-gv"):desc("move text down")
-- Stay in indent mode
mappings.v["<A-[>"] = map("<gv"):silent():desc("unindent line")
mappings.v["<A-]>"] = map(">gv"):silent():desc("indent line")
mappings.n["<A-[>"] = map("<<"):silent():desc("unindent line")
mappings.n["<A-]>"] = map(">>"):silent():desc("indent line")
mappings.i["<A-[>"] = map("<C-d>"):silent():noremap():desc("unindent line")
mappings.i["<A-]>"] = map("<C-t>"):silent():noremap():desc("indent line")

-- Lazy
mappings.n["<leader>z"] = map(function()
  require("lazy").show()
end):desc(wk_icons.z)

-- File Explorer
mappings.n["<A-1>"] = map("<CMD>NvimTreeToggle<CR>"):desc(wk_icons.e)

-- UI assistance
local ui = require("nvshan.keymap.helpers")
mappings.n["<leader>u"] = map():desc(wk_icons.u)
mappings.n["<leader>ua"] = map(ui.toggle_autopairs):desc("Toggle autopairs")
mappings.n["<leader>ub"] = map(ui.toggle_background):desc("Toggle background")
mappings.n["<leader>uc"] = map(ui.toggle_cmp):desc("Toggle auto completion")
mappings.n["<leader>uC"] = map(ui.toggle_conceal):desc("Toggle conceal")
mappings.n["<leader>ud"] = map(ui.toggle_diagnostics):desc("Toggle diagnostics virtual text")
if is_available("gitsigns.nvim") then
  mappings.n["<leader>ug"] = map(ui.toggle_git_blame):desc("Toggle git signs")
end
mappings.n["<leader>uL"] = map(ui.toggle_codelens):desc("Toggle code lens")
mappings.n["<leader>uw"] = map(ui.toggle_wrap):desc("toggle wrap")
mappings.n["<leader>us"] = map(ui.toggle_spell):desc("Toggle spellcheck")
mappings.n["<leader>uS"] = map(ui.toggle_statusline):desc("Toggle status line")
mappings.n["<leader>uT"] = map(ui.toggle_treesitter_context):desc("Toggle treesitter context")

-- nvim-ufo
if is_available("nvim-ufo") then
  mappings.n["zp"] = map(function()
    require("ufo").peekFoldedLinesUnderCursor()
  end):desc("Peek folded lines under cursor")
end

-- Others
if is_available("barbecue.nvim") then
  mappings.n["[e"] = map(function()
    require("barbecue.ui").navigate(-2)
  end):desc("Previous barbecue")
end
if global.is_mac then
  mappings.n["<leader>?"] = map("<CMD>silent !open dict://<cword><CR>"):desc("Open current word in dictionary")
end

mappings.n["gl"] = map(function()
  if vim.bo.filetype == "toggleterm" then
    vim.notify("under toggleterm")
    custom_functions.go_to_stack_trace()
  else
    vim.notify("not under toggleterm", vim.log.levels.INFO)
    vim.cmd("gd")
  end
end):desc("Go to debug line")
mappings.n["<leader>cc"] = map(custom_functions.compile_run):desc("Compile and run")
mappings.n["<leader>cg"] = map(custom_functions.toggle_glow):desc("Glow")
mappings.n["<leader>gg"] = map(custom_functions.toggle_lazygit):desc("Lazygit")
mappings.n["<leader>tj"] = map(custom_functions.toggle_joshuto):desc("Joshuto")

return mappings
