-- LSP setup, diagnostics, keymaps, and commands

-- Mason deferred to VimEnter for faster startup (lua/lsp/mason.lua)
vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		pcall(require, "lsp.mason")
	end,
})

-- Enable and configure servers
local servers = require("lsp.servers")
for lsp_name, lsp_config in pairs(servers) do
	vim.lsp.config(lsp_name, lsp_config)
	vim.lsp.enable(lsp_name)
end

-- Diagnostic configuration
do
	local icons = require("icons").diagnostics
	vim.diagnostic.config({
		-- virtual_text = { prefix = "●", spacing = 4 },
		virtual_text = false,
		jump = {
			on_jump = function(_, bufnr)
				vim.diagnostic.open_float({ bufnr = bufnr })
			end,
		},
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = icons.Error,
				[vim.diagnostic.severity.WARN] = icons.Warning,
				[vim.diagnostic.severity.INFO] = icons.Information,
				[vim.diagnostic.severity.HINT] = icons.Hint,
			},
		},
		underline = true,
		update_in_insert = false,
		severity_sort = true,
		float = {
			border = "rounded",
			source = true,
			header = "",
			prefix = "",
			focusable = false,
			style = "minimal",
		},
	})
end

-- Rounded border for all LSP floats
do
	local orig = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or "rounded"
		return orig(contents, syntax, opts, ...)
	end
end

-- LSP attach keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end

		local opts = { buffer = args.buf, silent = true }

		-- LSP keymaps via fzf-lua
		vim.keymap.set(
			"n",
			"<leader>ld",
			"<cmd>FzfLua lsp_definitions<cr>",
			vim.tbl_extend("force", opts, { desc = "Go to definition" })
		)
		vim.keymap.set(
			"n",
			"<leader>lr",
			"<cmd>FzfLua lsp_references<cr>",
			vim.tbl_extend("force", opts, { desc = "Go to references" })
		)
		vim.keymap.set(
			"n",
			"<leader>li",
			"<cmd>FzfLua lsp_implementations<cr>",
			vim.tbl_extend("force", opts, { desc = "Go to implementation" })
		)
		vim.keymap.set(
			"n",
			"<leader>lt",
			"<cmd>FzfLua lsp_typedefs<cr>",
			vim.tbl_extend("force", opts, { desc = "Go to type definition" })
		)
		vim.keymap.set(
			"n",
			"<leader>la",
			"<cmd>FzfLua lsp_code_actions<cr>",
			vim.tbl_extend("force", opts, { desc = "Code actions" })
		)
		vim.keymap.set(
			"n",
			"<leader>ls",
			"<cmd>FzfLua lsp_document_symbols<cr>",
			vim.tbl_extend("force", opts, { desc = "Document symbols" })
		)
		vim.keymap.set(
			"n",
			"<leader>lw",
			"<cmd>FzfLua lsp_workspace_symbols<cr>",
			vim.tbl_extend("force", opts, { desc = "Workspace symbols" })
		)
		vim.keymap.set(
			"n",
			"<leader>lW",
			"<cmd>FzfLua diagnostics_workspace<cr>",
			vim.tbl_extend("force", opts, { desc = "Workspace diagnostics" })
		)
		vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "LSP rename" }))
		vim.keymap.set(
			"n",
			"<leader>ldiag",
			vim.diagnostic.open_float,
			vim.tbl_extend("force", opts, { desc = "Diagnostic float" })
		)
		vim.keymap.set("n", "<leader>lf", function()
			vim.lsp.buf.format({ bufnr = args.buf, timeout_ms = 2000, name = "efm" })
		end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))

		-- LSP keymaps (gd/gD/gs)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
		vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))
	end,
})

-- efm-langserver (linting + formatting)
do
	local ok, _ = pcall(require, "efmls-configs")
	if ok then
		local function safe(name)
			local ok_mod, mod = pcall(require, name)
			return ok_mod and mod or {}
		end

		local luacheck = safe("efmls-configs.linters.luacheck")
		local stylua = safe("efmls-configs.formatters.stylua")
		local flake8 = safe("efmls-configs.linters.flake8")
		local black = safe("efmls-configs.formatters.black")
		local prettier_d = safe("efmls-configs.formatters.prettier_d")
		local fixjson = safe("efmls-configs.formatters.fixjson")
		local shellcheck = safe("efmls-configs.linters.shellcheck")
		local shfmt = safe("efmls-configs.formatters.shfmt")
		local cpplint = safe("efmls-configs.linters.cpplint")
		local clangfmt = safe("efmls-configs.formatters.clang_format")

		vim.lsp.config("efm", {
			filetypes = {
				"c",
				"cpp",
				"css",
				"html",
				"json",
				"jsonc",
				"lua",
				"markdown",
				"python",
				"sh",
			},
			init_options = { documentFormatting = true },
			settings = {
				languages = {
					lua = { luacheck, stylua },
					python = { flake8, black },
					sh = { shellcheck, shfmt },
					c = { clangfmt, cpplint },
					cpp = { clangfmt, cpplint },
					json = { fixjson },
					jsonc = { fixjson },
					css = { prettier_d },
					html = { prettier_d },
					markdown = { prettier_d },
				},
			},
		})

		vim.lsp.enable("efm")
	end
end

-- Format on save via efm
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
	pattern = { "*.lua", "*.py", "*.json", "*.css", "*.html", "*.c", "*.cpp", "*.h", "*.hpp" },
	callback = function(args)
		if vim.bo[args.buf].buftype ~= "" then
			return
		end
		local clients = vim.lsp.get_clients({ name = "efm", bufnr = args.buf })
		if #clients == 0 then
			return
		end
		vim.lsp.buf.format({ bufnr = args.buf, timeout_ms = 2000, name = "efm" })
	end,
})

-- Autopairs
vim.api.nvim_create_autocmd("InsertEnter", {
	once = true,
	callback = function()
		local ok, autopairs = pcall(require, "nvim-autopairs")
		if ok then
			autopairs.setup()
		end
	end,
})

-- LSP commands
vim.api.nvim_create_user_command("LspInfo", ":checkhealth vim.lsp", { desc = "Check LSP health" })
vim.api.nvim_create_user_command("LspLog", function()
	vim.cmd(string.format("tabnew %s", vim.lsp.log.get_filename()))
end, { desc = "Open LSP log" })
