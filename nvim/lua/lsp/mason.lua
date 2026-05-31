-- Mason setup (LSP/DAP/linter installer)
-- Deferred to VimEnter to keep startup fast
-- LSP servers still attach normally via lsp/init.lua

local ok_mason, mason = pcall(require, "mason")
if ok_mason then
	mason.setup()
end

-- Auto-install all LSP servers listed in servers.lua via mason
do
	local ok, mlsp = pcall(require, "mason-lspconfig")
	if ok then
		local servers = require("lsp.servers")
		mlsp.setup({
			ensure_installed = vim.tbl_keys(servers),
			automatic_installation = true,
		})
	end
end

-- Auto-install efm-langserver and formatters/linters via mason
do
	local ok, mti = pcall(require, "mason-tool-installer")
	if ok then
		mti.setup({
			ensure_installed = {
				"efm",
				"stylua",
				"black", "flake8",
				"shfmt", "shellcheck",
				"clang-format", "cpplint",
				"prettierd", "fixjson",
			},
			auto_update = true,
			run_on_start = true,
		})
	end
end
