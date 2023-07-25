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
maps.n["<C-s>"] = { "<cmd>w!<cr>", desc = "Force write" }
maps.n["<C-q>"] = { "<cmd>q!<cr>", desc = "Force quit" }

-- Split Navigation
maps.n["<C-h>"] = { "<C-w>h", desc = "Move to left split" }
maps.n["<C-j>"] = { "<C-w>j", desc = "Move to below split" }
maps.n["<C-k>"] = { "<C-w>k", desc = "Move to above split" }
maps.n["<C-l>"] = { "<C-w>l", desc = "Move to right split" }
maps.n["<C-Up>"] = { "<cmd>resize -2<CR>", desc = "Resize split up" }
maps.n["<C-Down>"] = { "<cmd>resize +2<CR>", desc = "Resize split down" }
maps.n["<C-Left>"] = { "<cmd>vertical resize -2<CR>", desc = "Resize split left" }
maps.n["<C-Right>"] = { "<cmd>vertical resize +2<CR>", desc = "Resize split right" }

-- Buffer Navigation
maps.n["S-l"] = { ":bnext<CR>", desc = "Move to next buffer" }
maps.n["S-h"] = { ":bprevious<CR>", desc = "Move to next buffer" }

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
  local builtin = require('telescope.builtin')
  maps.n["<leader>f"] = sections.f
  maps.n["<leader>g"] = sections.g
  maps.n["<leader>gb"] = { builtin.git_branches, desc = "Git branches" }
  maps.n["<leader>gc"] = { builtin.git_commits, desc = "Git commits" }
  maps.n["<leader>gt"] = { builtin.git_status, desc = "Git status" }
  maps.n["<leader>f<CR>"] = { builtin.resume, desc = "Resume previous search" }
  maps.n["<leader>f'"] = { builtin.marks, desc = "Find marks" }

  maps.n["<leader>fb"] = { builtin.buffers, desc = "Find buffers" }
  maps.n["<leader>fc"] = { builtin.grep_string, desc = "Find for word under cursor" }
  maps.n["<leader>fC"] = { builtin.commands, desc = "Find commands" }
  maps.n["<leader>ff"] = { builtin.find_files, desc = "Find files" }
  maps.n["<leader>fh"] = { builtin.help_tags, desc = "Find help" }
  maps.n["<leader>fk"] = { builtin.keymaps, desc = "Find keymaps" }
  maps.n["<leader>fm"] = { builtin.man_pages, desc = "Find man" }
  if is_available("nvim-notify") then
    maps.n["<leader>fn"] = {
      function()
        require("telescope").extensions.notify.notify()
      end,
      desc = "Find notifications",
    }
  end
  maps.n["<leader>fo"] = { builtin.oldfiles, desc = "Find history" }
  maps.n["<leader>fr"] = { builtin.registers, desc = "Find registers" }
  maps.n["<leader>ft"] = {
    function()
      require("telescope.builtin").colorscheme({ enable_preview = true })
    end,
    desc = "Find themes",
  }
  maps.n["<leader>fw"] = { builtin.live_grep, desc = "Find words" }
  maps.n["<leader>fW"] = {
    function()
      require("telescope.builtin").live_grep({
        additional_args = function(args)
          return vim.list_extend(args, { "--hidden", "--no-ignore" })
        end,
      })
    end,
    desc = "Find words in all files",
  }
  maps.n["<leader>lD"] = { builtin.diagnostics, desc = "Search diagnostics" }
end

-- GitSigns
if is_available("gitsigns.nvim") then
  maps.n["<leader>g"] = sections.g
  maps.n["]g"] = {
    function()
      require("gitsigns").next_hunk()
    end,
    desc = "Next Git hunk",
  }
  maps.n["[g"] = {
    function()
      require("gitsigns").prev_hunk()
    end,
    desc = "Previous Git hunk",
  }
  maps.n["<leader>gl"] = {
    function()
      require("gitsigns").blame_line()
    end,
    desc = "View Git blame",
  }
  maps.n["<leader>gL"] = {
    function()
      require("gitsigns").blame_line({ full = true })
    end,
    desc = "View full Git blame",
  }
  maps.n["<leader>gp"] = {
    function()
      require("gitsigns").preview_hunk()
    end,
    desc = "Preview Git hunk",
  }
  maps.n["<leader>gh"] = {
    function()
      require("gitsigns").reset_hunk()
    end,
    desc = "Reset Git hunk",
  }
  maps.n["<leader>gr"] = {
    function()
      require("gitsigns").reset_buffer()
    end,
    desc = "Reset Git buffer",
  }
  maps.n["<leader>gs"] = {
    function()
      require("gitsigns").stage_hunk()
    end,
    desc = "Stage Git hunk",
  }
  maps.n["<leader>gS"] = {
    function()
      require("gitsigns").stage_buffer()
    end,
    desc = "Stage Git buffer",
  }
  maps.n["<leader>gu"] = {
    function()
      require("gitsigns").undo_stage_hunk()
    end,
    desc = "Unstage Git hunk",
  }
  maps.n["<leader>gd"] = {
    function()
      require("gitsigns").diffthis()
    end,
    desc = "View Git diff",
  }
end

-- LSP
maps.n["<leader>l"] = sections.l

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


utils.set_mappings(maps)
