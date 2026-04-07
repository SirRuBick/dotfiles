-- set up neodev first
local status_ok, neodev = pcall(require, "neodev")
if status_ok then
  neodev.setup({
    library = {
      enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
      -- these settings will be used for your Neovim config directory
      runtime = true, -- runtime path
      types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
      plugins = true, -- installed opt or start plugins in packpath
      -- you can also specify the list of plugins to make available as a workspace library
      -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
    },
    setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
    -- for your Neovim config directory, the config.library settings will be used as is
    -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
    -- for any other directory, config.library.enabled will be set to false
    override = function(root_dir, options) end,
    -- With lspconfig, Neodev will automatically setup your lua-language-server
    -- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
    -- in your lsp start options
    lspconfig = true,
    -- much faster, but needs a recent built of lua-language-server
    -- needs lua-language-server >= 3.6.0
    pathStrict = true,
  })
end

-- setup lsp
local lsp = require("nvshan.plugins.lsp.lsp-config")

local status_ok, servers = pcall(require, "nvshan.plugins.lsp.servers")
if not status_ok then
  vim.notify("No language server configured", vim.log.levels.WARN)
  return
end

local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = vim.tbl_deep_extend("force", {}, lsp.capabilities() or {}, has_cmp and cmp_nvim_lsp.default_capabilities() or {})

local handlers = {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) --default handler
    require("lspconfig")[server_name].setup({
      on_attach = lsp.on_attach,
      capabilities = capabilities,
    })
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
