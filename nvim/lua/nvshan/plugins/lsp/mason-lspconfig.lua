local lsp = require "nvshan.plugins.lsp.helper"


local status_ok, servers = pcall(require, "nvshan.plugins.lsp.servers")
if not status_ok then
  vim.notify("No language server configured", vim.log.levels.WARN)
  return
end


local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = vim.tbl_deep_extend(
  "force",
  {},
  has_cmp and cmp_nvim_lsp.default_capabilities() or {},
  lsp.capabilities or {}
)

local handlers = {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) --default handler
    require("lspconfig")[server_name].setup {
      on_attach = lsp.on_attach,
      capabilities = capabilities,
    }
  end,
}

-- additional pre-defined handlers
for server, opts in pairs(servers) do
  local overrides = {
    on_attach = lsp.on_attach,
    capabilities = capabilities,
  }

  local conf_opts = vim.tbl_deep_extend("force", opts, overrides)
  handlers[server] = function()
    require("lspconfig")[server].setup(conf_opts)
  end
end

-- setup lsp servers
require("mason-lspconfig").setup({
  ensure_installed = vim.tbl_keys(servers),
  automatic_installation = true,
  handlers = handlers,
})
