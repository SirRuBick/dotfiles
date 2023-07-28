-- ### keymaps
--
-- some key mapping for neovim
--
-- @Author: alex shan
-- @Date:   2023
--

local utils = require("utils")
local is_available = utils.is_available

local maps = { i = {}, n = {}, v = {}, t = {}, x = {} }

local sections = {
  f = { desc = "󰍉 Find" },
  p = { desc = "󰏖 Packages" },
  l = { desc = " LSP" },
  u = { desc = " UI" },
  b = { desc = "󰓩 Buffers" },
  bs = { desc = "󰒺 Sort Buffers" },
  d = { desc = " Debugger" },
  g = { desc = "󰊢 Git" },
  S = { desc = "󱂬 Session" },
  t = { desc = " Terminal" },
}
if not vim.g.icons_enabled then
  vim.tbl_map(function(opts)
    opts.desc = opts.desc:gsub("^.* ", "")
  end, sections)
end

-- Insert --
maps.i["jk"] = { "<ESC>", desc = "Exit" }

-- Normal --
maps.n["<C-s>"] = { "<cmd>w<cr>", desc = "Save file" }
maps.n["<C-q>"] = { "<cmd>q<cr>", desc = "Quit" }

-- Split Navigation
maps.n["<C-h>"] = { "<C-w>h", desc = "Move to left split" }
maps.n["<C-j>"] = { "<C-w>j", desc = "Move to below split" }
maps.n["<C-k>"] = { "<C-w>k", desc = "Move to above split" }
maps.n["<C-l>"] = { "<C-w>l", desc = "Move to right split" }
maps.n["<C-Up>"] = { "<cmd>resize -2<CR>", desc = "Resize split up" }
maps.n["<C-Down>"] = { "<cmd>resize +2<CR>", desc = "Resize split down" }
maps.n["<C-Left>"] = { "<cmd>vertical resize -2<CR>", desc = "Resize split left" }
maps.n["<C-Right>"] = { "<cmd>vertical resize +2<CR>", desc = "Resize split right" }

-- Buffers
maps.n["<leader>b"] = sections.b
if is_available("bufferline.nvim") then
  maps.n["<S-h>"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" }
  maps.n["<S-l>"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" }
  maps.n["[b"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" }
  maps.n["]b"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" }
  maps.n["<leader>bC"] = { "<cmd>BufferLineCloseOthers<cr>", desc = "Close all other buffers" }
  maps.n["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick and Close a buffer" }
  maps.n["<leader>bp"] = { "<cmd>BufferLinePick<cr>", desc = "Pick a buffer" }
else
  maps.n["<S-h>"] = { "<cmd>bprevious<cr>", desc = "Prev buffer" }
  maps.n["<S-l>"] = { "<cmd>bnext<cr>", desc = "Next buffer" }
  maps.n["[b"] = { "<cmd>bprevious<cr>", desc = "Prev buffer" }
  maps.n["]b"] = { "<cmd>bnext<cr>", desc = "Next buffer" }
end
maps.n["<leader>bb"] = { "<cmd>e #<cr>", desc = "Switch to Other Buffer" }
maps.n["<leader>`"] = { "<cmd>e #<cr>", desc = "Switch to Other Buffer" }

-- Improved Terminal Navigation
maps.t["<C-h>"] = { "<cmd>wincmd h<cr>", desc = "Terminal left window navigation" }
maps.t["<C-j>"] = { "<cmd>wincmd j<cr>", desc = "Terminal down window navigation" }
maps.t["<C-k>"] = { "<cmd>wincmd k<cr>", desc = "Terminal up window navigation" }
maps.t["<C-l>"] = { "<cmd>wincmd l<cr>", desc = "Terminal right window navigation" }
-- Tmux navigation
if is_available("vim-tmux-navigator") then
  maps.n["<C-h>"] = { "<cmd>TmuxNavigateLeft<cr>", desc = "Tmux left window navigation" }
  maps.n["<C-j>"] = { "<cmd>TmuxNavigateDown<cr>", desc = "Tmux down window navigation" }
  maps.n["<C-k>"] = { "<cmd>TmuxNavigateUp<cr>", desc = "Tmux up window navigation" }
  maps.n["<C-l>"] = { "<cmd>TmuxNavigateRight<cr>", desc = "Tmux right window navigation" }
  maps.n["<C-\\>"] = { "<cmd>TmuxNavigatePrevious<cr>", desc = "Tmux previous window navigation" }
  maps.n["<C-]>"] = { "<cmd>TmuxNavigateNext<cr>", desc = "Tmux next window navigation" }
  maps.n["<C-/>"] = { "<cmd>TmuxNavigateLast<cr>", desc = "Tmux last window navigation" }
end

-- Visual --
-- Move text up and down
maps.v["<A-j>"] = { ":m .+1<CR>==", desc = "move text up" }
maps.v["<A-k>"] = { ":m .-2<CR>==", desc = "move text down" }
maps.x["J"] = { ":move '>+1<CR>gv-gv", desc = "move text up" }
maps.x["K"] = { ":move '<-2<CR>gv-gv", desc = "move text down" }
maps.x["<A-j>"] = { ":move '>+1<CR>gv-gv", desc = "move text up" }
maps.x["<A-k>"] = { ":move '<-2<CR>gv-gv", desc = "move text down" }
-- Stay in indent mode
maps.v["<"] = { "<gv", desc = "unindent line" }
maps.v[">"] = { ">gv", desc = "indent line" }


-- Plugins --
-- Comment
if is_available("Comment.nvim") then
  maps.n["<leader>/"] = {
    function()
      require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
    end,
    desc = "Comment line",
  }
  maps.v["<leader>/"] = {
    "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
    desc = "Toggle comment line",
  }
end

-- Telescope
if is_available("telescope.nvim") then
  maps.n["<leader>f"] = sections.f
  maps.n["<leader>g"] = sections.g
  maps.n["<leader>gb"] = { require('telescope.builtin').git_branches, desc = "Git branches" }
  maps.n["<leader>gc"] = { require('telescope.builtin').git_commits, desc = "Git commits" }
  maps.n["<leader>gt"] = { require('telescope.builtin').git_status, desc = "Git status" }
  maps.n["<leader>f<CR>"] = { require('telescope.builtin').resume, desc = "Resume previous search" }
  maps.n["<leader>f'"] = { require('telescope.builtin').marks, desc = "Find marks" }

  maps.n["<leader>fb"] = { require('telescope.builtin').buffers, desc = "Find buffers" }
  maps.n["<leader>fc"] = { require('telescope.builtin').grep_string, desc = "Find for word under cursor" }
  maps.n["<leader>fC"] = { require('telescope.builtin').commands, desc = "Find commands" }
  maps.n["<leader>ff"] = { require('telescope.builtin').find_files, desc = "Find files" }
  maps.n["<leader>fh"] = { require('telescope.builtin').help_tags, desc = "Find help" }
  maps.n["<leader>fk"] = { require('telescope.builtin').keymaps, desc = "Find keymaps" }
  maps.n["<leader>fm"] = { require('telescope.builtin').man_pages, desc = "Find man" }
  if is_available("nvim-notify") then
    maps.n["<leader>fn"] = {
      function()
        require("telescope").extensions.notify.notify()
      end,
      desc = "Find notifications",
    }
  end
  maps.n["<leader>fo"] = { require('telescope.builtin').oldfiles, desc = "Find history" }
  maps.n["<leader>fr"] = { require('telescope.builtin').registers, desc = "Find registers" }
  maps.n["<leader>ft"] = { require('telescope.builtin').colorscheme, desc = "Find themes" }
  maps.n["<leader>fw"] = { require('telescope.builtin').live_grep, desc = "Find words" }
  maps.n["<leader>fW"] = {
    function()
      require('telescope.builtin').live_grep({
        additional_args = function(args)
          return vim.list_extend(args, { "--hidden", "--no-ignore" })
        end,
      })
    end,
    desc = "Find words in all files",
  }
  maps.n["<leader>lD"] = { require('telescope.builtin').diagnostics, desc = "Search diagnostics" }
end

-- GitSigns
if is_available("gitsigns.nvim") then
  maps.n["<leader>g"] = sections.g
  maps.n["]g"] = { require("gitsigns").next_hunk(), desc = "Git: Next Git hunk" }
  maps.n["[g"] = { require("gitsigns").prev_hunk(), desc = "Git: Previous Git hunk" }
  maps.n["<leader>gl"] = { require("gitsigns").blame_line, desc = "View Git blame" }
  maps.n["<leader>gL"] = {
    function() require("gitsigns").blame_line { full = true } end,
    desc = "Git: View full Git blame"
  }
  maps.n["<leader>gp"] = { require("gitsigns").preview_hunk, desc = "Git: Preview Git hunk" }
  maps.n["<leader>gh"] = { require("gitsigns").reset_hunk, desc = "Git: Reset Git hunk" }
  maps.n["<leader>gr"] = { require("gitsigns").reset_buffer, desc = "Git: Reset Git buffer" }
  maps.n["<leader>gs"] = { require("gitsigns").stage_hunk, desc = "Git: Stage Git hunk" }
  maps.n["<leader>gS"] = { require("gitsigns").stage_buffer, desc = "Git: Stage Git buffer" }
  maps.n["<leader>gu"] = { require("gitsigns").undo_stage_hunk, desc = "Git: Unstage Git hunk" }
  maps.n["<leader>gd"] = { require("gitsigns").diffthis, desc = "Git: View Git diff" }
end

-- LSP
maps.n["<leader>l"] = sections.l

-- DAP
if is_available "nvim-dap" then
  maps.n["<leader>d"] = sections.d
  maps.v["<leader>d"] = sections.d
  -- modified function keys found with `showkey -a` in the terminal to get key code
  -- run `nvim -V3log +quit` and search through the "Terminal info" in the `log` file for the correct keyname
  maps.n["<F5>"] = { require("dap").continue, desc = "Debugger: Start" }
  maps.n["<F6>"] = { require("dap").step_over, desc = "Debugger: Step Over" }
  maps.n["<F7>"] = { require("dap").step_into, desc = "Debugger: Step Into" }
  maps.n["<F8>"] = { require("dap").step_out, desc = "Debugger: Step Out" }
  maps.n["<F9>"] = { require("dap").pause, desc = "Debugger: Pause" }
  maps.n["C-<F9>"] = { require("dap").terminate, desc = "Debugger: Stop" }
  maps.n["C-<F5>"] = { require("dap").restart_frame, desc = "Debugger: Restart" }
  maps.n["<leader>dB"] = { -- Shift+F9
    function()
      vim.ui.input({ prompt = "Condition: " }, function(condition)
        if condition then require("dap").set_breakpoint(condition) end
      end)
    end,
    desc = "Debugger: Conditional Breakpoint",
  }
  maps.n["<leader>db"] = { require("dap").toggle_breakpoint, desc = "Toggle Breakpoint (F9)" }
  maps.n["<leader>dC"] = { require("dap").clear_breakpoints, desc = "Clear Breakpoints" }

  maps.n["<leader>dc"] = { require("dap").continue, desc = "Debugger: Continue (F5)" }
  maps.n["<leader>di"] = { require("dap").step_into, desc = "Step Into (F7)" }
  maps.n["<leader>do"] = { require("dap").step_over, desc = "Step Over (F6)" }
  maps.n["<leader>dO"] = { require("dap").step_out, desc = "Step Out (F8)" }
  maps.n["<leader>dq"] = { require("dap").close, desc = "Close Session" }
  maps.n["<leader>dQ"] = { require("dap").terminate, desc = "Terminate Session (C-F9)" }
  maps.n["<leader>dp"] = { require("dap").pause, desc = "Pause (F9)" }
  maps.n["<leader>dr"] = { require("dap").restart_frame, desc = "Restart (C-F5)" }
  maps.n["<leader>dR"] = { require("dap").repl.toggle, desc = "Toggle REPL" }
  maps.n["<leader>ds"] = { require("dap").run_to_cursor, desc = "Run To Cursor" }
  maps.n["<leader>dl"] = { require("dap").run_last, desc = "Run Last" }

  if is_available "nvim-dap-ui" then
    maps.n["<leader>dE"] = {
      function()
        vim.ui.input({ prompt = "Expression: " }, function(expr)
          if expr then require("dapui").eval(expr) end
        end)
      end,
      desc = "Evaluate Input",
    }
    -- maps.v["<leader>dE"] = { require("dapui").eval, desc = "Evaluate Input" }
    maps.n["<leader>du"] = { require("dapui").toggle, desc = "Toggle Debugger UI" }
    maps.n["<leader>dh"] = { require("dap.ui.widgets").hover, desc = "Debugger Hover" }
  end
end

-- Neo Tree
if is_available("neo-tree.nvim") then
  maps.n["<leader>e"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" }
  maps.n["<leader>o"] = {
    function()
      if vim.bo.filetype == "neo-tree" then
        vim.cmd.wincmd("p")
      else
        vim.cmd.Neotree("focus")
      end
    end,
    desc = "Toggle Explorer Focus",
  }
end

-- Plugin Manager
maps.n["<leader>p"] = sections.p
maps.n["<leader>pi"] = { require("lazy").install, desc = "Plugins Install" }
maps.n["<leader>ps"] = { require("lazy").home, desc = "Plugins Status" }
maps.n["<leader>pS"] = { require("lazy").sync, desc = "Plugins Sync" }
maps.n["<leader>pu"] = { require("lazy").check, desc = "Plugins Check Updates" }
maps.n["<leader>pU"] = { require("lazy").update, desc = "Plugins Update" }

-- UI --
maps.n["<leader>u"] = sections.u
local ui = require("utils.ui")
if is_available "nvim-autopairs" then
  maps.n["<leader>ua"] = { ui.toggle_autopairs, desc = "Toggle autopairs" }
end
if is_available "nvim-cmp" then
  maps.n["<leader>uc"] = { ui.toggle_cmp, desc = "Toggle autocompletion" }
end

maps.n["<leader>ud"] = { ui.toggle_diagnostics, desc = "Toggle diagnostics" }
maps.n["<leader>ul"] = { ui.toggle_statusline, desc = "Toggle statusline" }
maps.n["<leader>uL"] = { ui.toggle_codelens, desc = "Toggle CodeLens" }
maps.n["<leader>us"] = { ui.toggle_spell, desc = "Toggle spellcheck" }
maps.n["<leader>uS"] = { ui.toggle_conceal, desc = "Toggle conceal" }
maps.n["<leader>uw"] = { ui.toggle_wrap, desc = "Toggle wrap" }
-- Trouble

maps.n["<leader>uX"] = { "<cmd>TroubleToggle<cr>", desc = "Touble: Toggle" }
maps.n["<leader>uW"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Trouble: Toggle workspace diagnostics" }
maps.n["<leader>uD"] = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Trouble: Toggle document diagnostics" }
maps.n["<leader>uL"] = { "<cmd>TroubleToggle loclist<cr>", desc = "Trouble: Open location list" }
maps.n["<leader>uQ"] = { "<cmd>TroubleToggle quickfix<cr>", desc = "Trouble: Quick Fix" }
maps.n["<leader>uR"] = { "<cmd>TroubleToggle lsp_references<cr>", desc = "Trouble: LSP reference" }


utils.set_mappings(maps)
