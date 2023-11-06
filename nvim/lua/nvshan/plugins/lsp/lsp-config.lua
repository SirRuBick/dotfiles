local Config = {}

local is_available = require("utils").is_available
local keymap_utils = require("nvshan.keymap.utils")
local map = keymap_utils.map
local wk_icons = require("icons").whichkey


--- The `on_attach` function used by lspconfig
---@param client table The LSP client details when attaching
---@param bufnr number The buffer that the LSP client is attaching to
Config.on_attach = function(client, bufnr)
  local capabilities = client.server_capabilities
  local lsp_mappings = keymap_utils.init_mapping()
  
  lsp_mappings.n["<leader>l"] = map():buffer(bufnr):desc(wk_icons.l)

  lsp_mappings.n["<leader>ld"] = map(vim.diagnostic.open_float):buffer(bufnr):desc("Hover diagnostics")
  lsp_mappings.n["[d"] = map(vim.diagnostic.goto_prev):buffer(bufnr):desc("Previous diagnostic")
  lsp_mappings.n["]d"] = map(vim.diagnostic.goto_next):buffer(bufnr):desc("Next diagnostic")
  lsp_mappings.n["gl"] = map(vim.diagnostic.open_float):buffer(bufnr):desc("Hover diagnostics")

  if is_available "mason-lspconfig.nvim" then
    lsp_mappings.n["<leader>li"] = map("<cmd>LspInfo<CR>"):buffer(bufnr):desc("LSP information")
  end

  if capabilities.codeActionProvider then
    lsp_mappings.n["<leader>la"] = map(vim.lsp.buf.code_action):buffer(bufnr):desc("LSP code action")
    lsp_mappings.v["<leader>la"] = map(vim.lsp.buf.code_action):buffer(bufnr):desc("LSP code action")
  end

  if capabilities.declarationProvider then
    lsp_mappings.n["gD"] = map(vim.lsp.buf.declaration):buffer(bufnr):desc("Declaration of current symbol")
  end

  if capabilities.definitionProvider then
    lsp_mappings.n["gd"] = map(vim.lsp.buf.definition):buffer(bufnr):desc("Show the definition of current symbol")
  end

  if capabilities.documentFormattingProvider then
    lsp_mappings.n["<leader>lf"] = map(vim.lsp.buf.format):buffer(bufnr):desc("Format buffer")
    lsp_mappings.v["<leader>lf"] = lsp_mappings.n["<leader>lf"]
  end

  if capabilities.hoverProvider then
    lsp_mappings.n["K"] = map(vim.lsp.buf.hover):buffer(bufnr):desc("Hover symbol details")
  end

  if capabilities.implementationProvider then
    lsp_mappings.n["gI"] = map(vim.lsp.buf.implementation):buffer(bufnr):desc("Implementation of current symbol")
  end

  if capabilities.referencesProvider then
    lsp_mappings.n["gr"] = map(vim.lsp.buf.references):buffer(bufnr):desc("References of current symbol")
    lsp_mappings.n["<leader>lR"] = map(vim.lsp.buf.references):buffer(bufnr):desc("Search references")
  end

  if capabilities.renameProvider then
    lsp_mappings.n["<leader>lr"] = map(vim.lsp.buf.rename):buffer(bufnr):desc("Rename current symbol")
  end

  if capabilities.signatureHelpProvider then
    lsp_mappings.n["<leader>lh"] = map(vim.lsp.buf.signature_help):buffer(bufnr):desc("Signature help")
  end

  if capabilities.typeDefinitionProvider then
    lsp_mappings.n["gT"] = map(vim.lsp.buf.type_definition):buffer(bufnr):desc("Definition of current type")
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
    lsp_mappings.n["<leader>l"] = map():buffer(bufnr):desc(wk_icons.l)
  end

  keymap_utils.load_keymaps(lsp_mappings)
end

--- The lsp capabilities to be used by lspconfig
Config.capabilities = vim.lsp.protocol.make_client_capabilities()


return Config
