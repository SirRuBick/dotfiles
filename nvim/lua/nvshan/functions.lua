local M = {}
local is_available = require("utils").is_available

local function split()
	vim.cmd("set splitbelow")
	vim.cmd("sp")
	vim.cmd("res -5")
end

-- TODO: integrate with toggleterm and merge with markdown preview
function M.cimpileRun()
	local ft = vim.bo.filetype
	if ft == "markdown" then
		vim.cmd("MarkdownPreview")
	elseif ft == "c" then
		split()
		vim.cmd("term gcc % -o %< && ./%< && rm %<")
	elseif ft == "lua" then
		split()
		vim.cmd("term luajit %")
	end
end

function M.go_to_stack_trace()
	local line = vim.api.nvim_get_current_line()
	local pattern = 'File "(.-)", line (%d+)'
	local file_path, line_number = line:match(pattern)
	if file_path and line_number then
		vim.cmd(":wincmd k")
		vim.cmd("e " .. file_path)
		vim.api.nvim_win_set_cursor(0, { tonumber(line_number), 0 })
	end
end

if is_available("toggleterm.nvim") then
	function M.toggle_glow()
		local Terminal = require("toggleterm.terminal").Terminal
		local glow = Terminal:new({
			cmd = "glow",
			direction = "float",
			hidden = true,
      on_open = function(term)
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
      end,
		})
    glow:toggle()
	end
  -- TODO: more custom terminal
end

return M
