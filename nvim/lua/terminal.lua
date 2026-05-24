-- Terminal tools module
-- Modular floating terminal system using built-in Neovim terminal
-- Add new tools to M.tools table for easy extension

local M = {}

-- Per-tool terminal state
local terms = {}

-- Cross‑platform shell detection
local function get_shell()
	if vim.fn.has("win32") == 1 then
		-- Try PowerShell Core, then Windows PowerShell, then cmd
		if vim.fn.executable("pwsh") == 1 then
			return "pwsh"
		elseif vim.fn.executable("powershell") == 1 then
			return "powershell"
		else
			return "cmd"
		end
	else
		-- Unix: use $SHELL, or fall back to sh
		return vim.env.SHELL or "sh"
	end
end

-- Floating window config
local function float_opts(width_ratio, height_ratio)
	local width = math.floor(vim.o.columns * width_ratio)
	local height = math.floor(vim.o.lines * height_ratio)
	return {
		relative = "editor",
		width = width,
		height = height,
		col = math.floor((vim.o.columns - width) / 2),
		row = math.floor((vim.o.lines - height) / 2),
		style = "minimal",
		border = "rounded",
	}
end

-- Open or toggle a floating terminal for a given command
function M.open(cmd, opts)
	opts = opts or {}
	local name = opts.name or "FloatTerm"
	local width_ratio = opts.width or 0.8
	local height_ratio = opts.height or 0.8
	local state = terms[name]

	-- If terminal exists and is visible, close it
	if state and state.buf and vim.api.nvim_buf_is_valid(state.buf) then
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == state.buf then
				vim.api.nvim_win_close(win, true)
				return
			end
		end
		-- Terminal exists but not visible — reopen
		M._open_float(state.buf, width_ratio, height_ratio, name)
		vim.cmd("startinsert")
		return
	end

	-- Create new terminal buffer
	local buf = vim.api.nvim_create_buf(false, true)
	vim.bo[buf].buflisted = false
	vim.api.nvim_buf_set_name(buf, "term://" .. name)

	M._open_float(buf, width_ratio, height_ratio, name)

	-- Start terminal in the buffer
	vim.cmd("buffer " .. buf)
	vim.fn.termopen(cmd or os.getenv("SHELL") or "powershell")
	vim.cmd("startinsert")

	terms[name] = { buf = buf, cmd = cmd }

	-- Auto-close on terminal exit
	vim.api.nvim_create_autocmd("TermClose", {
		buffer = buf,
		once = true,
		callback = function()
			if vim.api.nvim_buf_is_valid(buf) then
				vim.api.nvim_buf_delete(buf, { force = true })
			end
			terms[name] = nil
		end,
	})
end

-- Open a floating window for the given buffer
function M._open_float(buf, width_ratio, height_ratio, name)
	local win = vim.api.nvim_open_win(buf, true, float_opts(width_ratio, height_ratio))

	-- Close window on BufLeave
	vim.api.nvim_create_autocmd("BufLeave", {
		buffer = buf,
		once = true,
		callback = function()
			if win and vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_win_close(win, true)
			end
		end,
	})

	-- q to close from normal mode
	vim.keymap.set("n", "q", function()
		if win and vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
	end, { buffer = buf, silent = true, desc = "Close terminal" })
end

-- Toggle generic floating terminal
function M.toggle()
	M.open(nil, { name = "FloatTerm", width = 0.8, height = 0.8 })
end

-- ── Tool registry ───────────────────────────────────────────────────────────
-- Add new tools here: { cmd, width, height, keymap, desc }
-- Set keymap = nil to register without a keymap (use M.open() manually)

M.tools = {
	lazygit = {
		cmd = "lazygit",
		width = 0.9,
		height = 0.9,
		keymap = "<leader>gg",
		desc = "Lazygit",
	},
}

-- Register keymaps from tool table
for name, tool in pairs(M.tools) do
	if tool.keymap then
		vim.keymap.set("n", tool.keymap, function()
			M.open(tool.cmd, { name = name, width = tool.width, height = tool.height })
		end, { desc = tool.desc })
	end
end

-- Generic terminal toggle
vim.keymap.set("n", "<leader>tt", function()
	M.toggle()
end, { desc = "Toggle floating terminal" })
vim.keymap.set("t", "<C-\\><C-\\>", function()
	M.toggle()
end, { desc = "Toggle floating terminal" })

return M
