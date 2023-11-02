local M = {}

local utils = require "utils"
local is_available = utils.is_available

local server_config = "user.lsp.configs."
local setup_handlers = {
  function(server, opts) require("lspconfig")[server].setup(opts) end,
}


--- Helper function to set up a given server with the Neovim LSP client
---@param server string The name of the server to be setup
M.setup = function(server)
  -- if server doesn't exist, set it up from user server definition
  local config_avail, config = pcall(require, "lspconfig.server_configurations." .. server)
  if not config_avail or not config.default_config then
    local server_definition = require(server_config .. server)
    if server_definition.cmd then require("lspconfig.configs")[server] = { default_config = server_definition } end
  end
  local opts = M.config(server)
  local setup_handler = setup_handlers[server] or setup_handlers[1]
  if setup_handler then
    setup_handler(server, opts)
  end
end


--- The `on_attach` function used by Nvim
---@param client table The LSP client details when attaching
---@param bufnr number The buffer that the LSP client is attaching to
M.on_attach = function(client, bufnr)
  local capabilities = client.server_capabilities
  local lsp_mappings = { n = {}, v = {} }

  lsp_mappings.n["<leader>ld"] = { vim.diagnostic.open_float, desc = "Hover diagnostics" }
  lsp_mappings.n["[d"] = { vim.diagnostic.goto_prev, desc = "Previous diagnostic" }
  lsp_mappings.n["]d"] = { vim.diagnostic.goto_next, desc = "Next diagnostic" }
  lsp_mappings.n["gl"] = { vim.diagnostic.open_float, desc = "Hover diagnostics" }

  if is_available "mason-lspconfig.nvim" then
    lsp_mappings.n["<leader>li"] = { "<cmd>LspInfo<cr>", desc = "LSP information" }
  end

  if capabilities.codeActionProvider then
    lsp_mappings.n["<leader>la"] = { vim.lsp.buf.code_action, desc = "LSP code action" }
    lsp_mappings.v["<leader>la"] = { vim.lsp.buf.code_action, desc = "LSP code action" }
  end

  if capabilities.declarationProvider then
    lsp_mappings.n["gD"] = { vim.lsp.buf.declaration, desc = "Declaration of current symbol" }
  end

  if capabilities.definitionProvider then
    lsp_mappings.n["gd"] = { vim.lsp.buf.definition, desc = "Show the definition of current symbol" }
  end

  if capabilities.documentFormattingProvider then
    lsp_mappings.n["<leader>lf"] = { vim.lsp.buf.format, desc = "Format buffer" }
    lsp_mappings.v["<leader>lf"] = lsp_mappings.n["<leader>lf"]
  end

  if capabilities.hoverProvider then
    lsp_mappings.n["K"] = { vim.lsp.buf.hover, desc = "Hover symbol details" }
  end

  if capabilities.implementationProvider then
    lsp_mappings.n["gI"] = { vim.lsp.buf.implementation, desc = "Implementation of current symbol" }
  end

  if capabilities.referencesProvider then
    lsp_mappings.n["gr"] = { vim.lsp.buf.references, desc = "References of current symbol" }
    lsp_mappings.n["<leader>lR"] = { vim.lsp.buf.references, desc = "Search references" }
  end

  if capabilities.renameProvider then
    lsp_mappings.n["<leader>lr"] = { vim.lsp.buf.rename, desc = "Rename current symbol" }
  end

  if capabilities.signatureHelpProvider then
    lsp_mappings.n["<leader>lh"] = { vim.lsp.buf.signature_help, desc = "Signature help" }
  end

  if capabilities.typeDefinitionProvider then
    lsp_mappings.n["gT"] = { vim.lsp.buf.type_definition, desc = "Definition of current type" }
  end

  if is_available "telescope.nvim" then -- setup telescope mappings if available
    local tele_builtin = require("telescope.builtin")
    if lsp_mappings.n.gd then lsp_mappings.n.gd[1] = tele_builtin.lsp_definitions end
    if lsp_mappings.n.gI then lsp_mappings.n.gI[1] = tele_builtin.lsp_implementations end
    if lsp_mappings.n.gr then lsp_mappings.n.gr[1] = require("telescope.builtin").lsp_references end
    if lsp_mappings.n["<leader>lR"] then lsp_mappings.n["<leader>lR"][1] = tele_builtin.lsp_references end
    if lsp_mappings.n.gT then lsp_mappings.n.gT[1] = tele_builtin.lsp_type_definitions end
  end

  if not vim.tbl_isempty(lsp_mappings.v) then
    lsp_mappings.v["<leader>l"] = { desc = (vim.g.icons_enabled and " " or "") .. "LSP" }
  end

  utils.set_mappings(lsp_mappings, { buffer = bufnr })
end

--- The default Nvim LSP capabilities
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.textDocument.completion.completionItem.preselectSupport = true
M.capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
M.capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
M.capabilities.textDocument.completion.completionItem.deprecatedSupport = true
M.capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
M.capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
M.capabilities.textDocument.completion.completionItem.resolveSupport =
{ properties = { "documentation", "detail", "additionalTextEdits" } }
M.capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }

--- Get the server configuration for a given language server to be provided to the server's `setup()` call
---@param server_name string The name of the server
---@return table # The table of LSP options used when setting up the given language server
function M.config(server_name)
  local server = require("lspconfig")[server_name]
  local lsp_opts = require("utils").extend_tbl(
    { capabilities = server.capabilities, flags = server.flags },
    { capabilities = M.capabilities, flags = M.flags }
  )
  -- if server_name == "jsonls" then -- by default add json schemas
  --   local schemastore_avail, schemastore = pcall(require, "schemastore")
  --   if schemastore_avail then
  --     lsp_opts.settings = { json = { schemas = schemastore.json.schemas(), validate = { enable = true } } }
  --   end
  -- end
  -- if server_name == "yamlls" then -- by default add yaml schemas
  --   local schemastore_avail, schemastore = pcall(require, "schemastore")
  --   if schemastore_avail then lsp_opts.settings = { yaml = { schemas = schemastore.yaml.schemas() } } end
  -- end
  -- if server_name == "lua_ls" then -- by default initialize neodev and disable third party checking
  --   pcall(require, "neodev")
  --   lsp_opts.settings = { Lua = { workspace = { checkThirdParty = false } } }
  -- end
  local opts = lsp_opts
  local old_on_attach = server.on_attach
  local user_on_attach = lsp_opts.on_attach
  opts.on_attach = function(client, bufnr)
    -- old_on_attach(client, bufnr)
    M.on_attach(client, bufnr)
    user_on_attach(client, bufnr)
  end
  return opts
end

return M
