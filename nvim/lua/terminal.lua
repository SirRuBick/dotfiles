-- Terminal tools module
-- Modular floating terminal system using built-in Neovim terminal
-- Add new tools to M.tools table for easy extension

local M = {}

-- Per-tool terminal state
local terms = {}

-- Cross‑platform shell detection – returns a list: { executable, arg... }
local function get_shell()
	if vim.fn.has("win32") == 1 then
		if vim.fn.executable("pwsh") == 1 then
			return { "pwsh", "-NoLogo" }
		elseif vim.fn.executable("powershell") == 1 then
			return { "powershell", "-NoLogo" }
		else
			return { "cmd" }
		end
	else
		local shell = vim.env.SHELL or "/bin/sh"
		return { shell }
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
		-- Terminal exists but not visible – reopen
		state.win = M._open_float(state.buf, width_ratio, height_ratio)
		vim.cmd("startinsert")
		return
	end

	-- Create a new terminal buffer
	local buf = vim.api.nvim_create_buf(false, true)
	vim.bo[buf].buflisted = false

	-- Open float window (enters the float, does not touch the original window's buffer)
	local win = M._open_float(buf, width_ratio, height_ratio)

	-- Start terminal in the float's buffer
	local shell_cmd = cmd or get_shell()
	vim.fn.termopen(shell_cmd)
	vim.cmd("startinsert")

	terms[name] = { buf = buf, cmd = cmd, win = win }

	-- Auto-close on terminal exit
	vim.api.nvim_create_autocmd("TermClose", {
		buffer = buf,
		once = true,
		callback = function()
			vim.schedule(function()
				if win and vim.api.nvim_win_is_valid(win) then
					pcall(vim.api.nvim_win_close, win, true)
				end
				if vim.api.nvim_buf_is_valid(buf) then
					vim.api.nvim_buf_delete(buf, { force = true })
				end
				if opts.on_exit then
					opts.on_exit()
				end
				terms[name] = nil
			end)
		end,
	})
end

-- Open a floating window for the given buffer
function M._open_float(buf, width_ratio, height_ratio)
	local win = vim.api.nvim_open_win(buf, true, float_opts(width_ratio, height_ratio))

	-- q to close from normal mode
	vim.keymap.set("n", "q", function()
		if win and vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
	end, { buffer = buf, silent = true, desc = "Close terminal" })

	return win
end

-- Toggle generic floating terminal
function M.toggle()
	local name = "FloatTerm"
	local state = terms[name]

	-- If visible, close it
	if state and state.buf and vim.api.nvim_buf_is_valid(state.buf) then
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == state.buf then
				vim.api.nvim_win_close(win, true)
				return
			end
		end
	end

	-- Open and focus into the terminal
	M.open(nil, { name = name, width = 0.8, height = 0.8 })
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
	yazi = {
		setup = function()
			local chooser = vim.fn.tempname()
			return { "yazi", "--chooser-file", chooser }, {
				name = "yazi",
				width = 0.9,
				height = 0.9,
				on_exit = function()
					local file = vim.fn.readfile(chooser)
					if #file > 0 and file[1] ~= "" then
						vim.cmd("edit " .. vim.fn.fnameescape(file[1]))
					end
					vim.fn.delete(chooser)
				end,
			}
		end,
		keymap = "<leader>z",
		desc = "Yazi file manager",
	},
}

-- Register keymaps from tool table
for name, tool in pairs(M.tools) do
	if tool.keymap then
		vim.keymap.set("n", tool.keymap, function()
			if tool.setup then
				local cmd, opts = tool.setup()
				M.open(cmd, opts)
			else
				M.open(tool.cmd, { name = name, width = tool.width, height = tool.height })
			end
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
