-- LSP setup, diagnostics, keymaps, and commands

-- Mason (LSP/DAP/linter installer)
local ok_mason, mason = pcall(require, "mason")
if ok_mason then
  mason.setup()
end

-- Enable and configure servers
local servers = require("lsp.servers")
for lsp_name, lsp_config in pairs(servers) do
  vim.lsp.enable(lsp_name)
  vim.lsp.config(lsp_name, lsp_config)
end

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 4 },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
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
    if not client then return end

    local opts = { buffer = args.buf, silent = true }

    -- LSP keymaps via fzf-lua
    vim.keymap.set("n", "<leader>cd", "<cmd>FzfLua lsp_definitions<cr>", vim.tbl_extend("force", opts, { desc = "Go to definition" }))
    vim.keymap.set("n", "<leader>cr", "<cmd>FzfLua lsp_references<cr>", vim.tbl_extend("force", opts, { desc = "Go to references" }))
    vim.keymap.set("n", "<leader>ci", "<cmd>FzfLua lsp_implementations<cr>", vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
    vim.keymap.set("n", "<leader>ct", "<cmd>FzfLua lsp_typedefs<cr>", vim.tbl_extend("force", opts, { desc = "Go to type definition" }))
    vim.keymap.set("n", "<leader>ca", "<cmd>FzfLua lsp_code_actions<cr>", vim.tbl_extend("force", opts, { desc = "Code actions" }))
    vim.keymap.set("n", "<leader>cs", "<cmd>FzfLua lsp_document_symbols<cr>", vim.tbl_extend("force", opts, { desc = "Document symbols" }))
    vim.keymap.set("n", "<leader>cw", "<cmd>FzfLua lsp_workspace_symbols<cr>", vim.tbl_extend("force", opts, { desc = "Workspace symbols" }))
    vim.keymap.set("n", "<leader>cW", "<cmd>FzfLua diagnostics_workspace<cr>", vim.tbl_extend("force", opts, { desc = "Workspace diagnostics" }))
    vim.keymap.set("n", "<leader>lw", "<cmd>FzfLua lsp_workspace_symbols<cr>", vim.tbl_extend("force", opts, { desc = "Workspace symbols" }))
    vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "LSP rename" }))
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Diagnostic float" }))
    vim.keymap.set("n", "<leader>lf", function()
      require("conform").format({ bufnr = args.buf })
    end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))
  end,
})

-- Conform (formatting)
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyFile",
  callback = function()
    local ok, conform = pcall(require, "conform")
    if not ok then return end
    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        rust = { "rustfmt", lsp_format = "fallback" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    })
  end,
})

-- Autopairs
vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = function()
    local ok, autopairs = pcall(require, "nvim-autopairs")
    if ok then autopairs.setup() end
  end,
})

-- LSP commands
vim.api.nvim_create_user_command("LspInfo", ":checkhealth vim.lsp", { desc = "Check LSP health" })
vim.api.nvim_create_user_command("LspLog", function()
  vim.cmd(string.format("tabnew %s", vim.lsp.log.get_filename()))
end, { desc = "Open LSP log" })

-- Pack commands
local function complete_plugin_names(ArgLead)
  local plugin_names = vim.iter(vim.pack.get()):map(function(p) return p.spec.name end):totable()
  return vim.iter(plugin_names):filter(function(name) return vim.startswith(name, ArgLead) end):totable()
end

vim.api.nvim_create_user_command("PackUpdate", function(opts)
  if opts.args == "" then vim.pack.update() else vim.pack.update(opts.fargs) end
end, { nargs = "*", desc = "Update packages", complete = complete_plugin_names })

vim.api.nvim_create_user_command("PackDel", function(opts)
  if opts.args == "" then vim.pack.del({}) else vim.pack.del(opts.fargs) end
end, { nargs = "*", desc = "Delete packages", complete = complete_plugin_names })

vim.api.nvim_create_user_command("PackGet", function(opts)
  if opts.args == "" then print(vim.inspect(vim.pack.get())) else print(vim.inspect(vim.pack.get(opts.fargs))) end
end, { nargs = "*", desc = "Get packages info", complete = complete_plugin_names })
