local utils = require "utils"
local lsp = require "plugins.configs.lsp.helper"


local status_ok, servers = pcall(require, "plugins.configs.lsp.servers")
if not status_ok then
  servers = {}
end


local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = vim.tbl_deep_extend(
  "force",
  {},
  has_cmp and cmp_nvim_lsp.default_capabilities() or {},
  lsp.capabilities or {}
)

local handlers = {
  function(server_name)   --default handler
    require("lspconfig")[server_name].setup {
      on_attach = lsp.on_attach,
      capabilities = capabilities,
      settings = servers[server_name],
    }
  end,
  -- more handlers to be added
}

-- for _, server in pairs(servers) do
--     local opts = {
--         on_attach = lsp.on_attach,
--         capabilities = capabilities,
--     }

--     server = vim.split(server, "@")[1]

--     local require_ok, conf_opts = pcall(require, "plugins.configs.lsp.handlers." .. server)
--     if require_ok then

--         conf_opts = vim.tbl_deep_extend("force", conf_opts, opts)
--         local overrides = {
--             [server] = function()
--                 lspconfig[server].setup(opts)
--             end
--         }
--         handlers = utils.extend_tbl(handlers, overrides)
--     end
-- end

require("mason-lspconfig").setup({
  ensure_installed = vim.tbl_keys(servers),
  automatic_installation = true,
  handlers = handlers,
})
