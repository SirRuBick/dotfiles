local Config = {}

local is_available = require("utils").is_available
local keymap_utils = require("nvshan.keymap.utils")
local map = keymap_utils.map
local wk_icons = require("icons").whichkey


--- The `on_attach` function used by lspconfig
---@param client table The LSP client details when attaching
---@param bufnr number The buffer that the LSP client is attaching to
Config.on_attach = function(client, bufnr)
  -- lsp modification autocmd
  if is_available("lsp-format-modifications.nvim") then
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "FormatModifications",
      function()
        local lsp_format_modifications = require "lsp-format-modifications"
        lsp_format_modifications.format_modifications(client, bufnr)
      end,
      {}
    )
  end

  -- keymaps
  local capabilities = client.server_capabilities
  local lsp_mappings = keymap_utils.init_mapping()

  lsp_mappings.n["<leader>l"] = map():buffer(bufnr):desc(wk_icons.l)

  if is_available "mason-lspconfig.nvim" then
    lsp_mappings.n["<leader>li"] = map("<cmd>LspInfo<CR>"):buffer(bufnr):desc("LSP information")
    lsp_mappings.n["<leader>lR"] = map("<cmd>LspRestart<CR>"):buffer(bufnr):desc("LSP Restart")
  end

  -- default lsp keymaps
  lsp_mappings.n["[d"] = map(vim.diagnostic.goto_prev):buffer(bufnr):desc("Previous diagnostic")
  lsp_mappings.n["]d"] = map(vim.diagnostic.goto_next):buffer(bufnr):desc("Next diagnostic")
  lsp_mappings.n["<leader>ld"] = map(vim.diagnostic.open_float):buffer(bufnr):desc("Hover diagnostics")
  lsp_mappings.n["<leader>ls"] = map(vim.diagnostic.document_symbol):buffer(bufnr):desc("Document Symbols")
  if capabilities.renameProvider then
    lsp_mappings.n["<leader>lr"] = map(vim.lsp.buf.rename):buffer(bufnr):desc("Rename current symbol")
  end
  if capabilities.hoverProvider then
    lsp_mappings.n["K"] = map(vim.lsp.buf.hover):buffer(bufnr):desc("Hover symbol details")
  end
  if capabilities.codeActionProvider then
    lsp_mappings.n["<leader>la"] = map(vim.lsp.buf.code_action):buffer(bufnr):desc("LSP code action")
    lsp_mappings.v["<leader>la"] = map(vim.lsp.buf.code_action):buffer(bufnr):desc("LSP code action")
  end
  if capabilities.definitionProvider then
    lsp_mappings.n["gd"] = map(vim.lsp.buf.definition):buffer(bufnr):desc("Show the definition of current symbol")
  end
  if capabilities.typeDefinitionProvider then
    lsp_mappings.n["gT"] = map(vim.lsp.buf.type_definition):buffer(bufnr):desc("Definition of current type")
  end

  if capabilities.declarationProvider then
    lsp_mappings.n["gD"] = map(vim.lsp.buf.declaration):buffer(bufnr):desc("Declaration of current symbol")
  end
  if capabilities.signatureHelpProvider then
    lsp_mappings.n["<leader>lh"] = map(vim.lsp.buf.signature_help):buffer(bufnr):desc("Signature help")
  end
  if capabilities.documentFormattingProvider then
    lsp_mappings.n["<leader>lf"] = map(vim.lsp.buf.format):buffer(bufnr):desc("Format buffer")
    lsp_mappings.v["<leader>lf"] = map(vim.lsp.buf.format):buffer(bufnr):desc("Format buffer")
    lsp_mappings.n["<leader>lm"] = map("<CMD>FormatModifications<CR>"):buffer(bufnr):desc("Format modifications only")
    lsp_mappings.v["<leader>lm"] = map("<CMD>FormatModifications<CR>"):buffer(bufnr):desc("Format modifications only")
  end
  if capabilities.implementationProvider then
    lsp_mappings.n["gI"] = map(vim.lsp.buf.implementation):buffer(bufnr):desc("Implementation of current symbol")
  end
  if capabilities.referencesProvider then
    lsp_mappings.n["gr"] = map(vim.lsp.buf.references):buffer(bufnr):desc("References of current symbol")
  end


  if is_available "lspsaga.nvim" then
    -- lsp saga specific keymaps
    lsp_mappings.n["<leader>lo"] = map("<CMD>Lspsaga outline<CR>"):buffer(bufnr):desc("Show outline")
    lsp_mappings.n["<leader>lc"] = map("<CMD>Lspsaga incoming_calls<CR>"):buffer(bufnr):desc("Show incoming calls")
    lsp_mappings.n["<leader>lC"] = map("<CMD>Lspsaga outgoing_calls<CR>"):buffer(bufnr):desc("Show outgoing calls")
    -- other keymaps
    if lsp_mappings.n["[d"] then lsp_mappings.n["[d"][1] = "<CMD>Lspsaga diagnostic_jump_prev<CR>" end
    if lsp_mappings.n["]d"] then lsp_mappings.n["]d"][1] = "<CMD>Lspsaga diagnostic_jump_next<CR>" end
    if lsp_mappings.n["<leader>ld"] then lsp_mappings.n["<leader>ld"][1] = "<CMD>Lspsaga show_line_diagnostics<CR>" end
    if lsp_mappings.n["<leader>lr"] then lsp_mappings.n["<leader>lr"][1] = "<CMD>Lspsaga rename<CR>" end
    if lsp_mappings.n["K"] then lsp_mappings.n["K"][1] = "<CMD>Lspsaga hover_doc<CR>" end
    if lsp_mappings.n["<leader>la"] then lsp_mappings.n["<leader>la"][1] = "<CMD>Lspsaga code_action<CR>" end
    if lsp_mappings.v["<leader>la"] then lsp_mappings.v["<leader>la"][1] = "<CMD>Lspsaga code_action<CR>" end
    if lsp_mappings.n["gd"] then lsp_mappings.n["gd"][1] = "<CMD>Lspsaga go_to_definition<CR>" end
    if lsp_mappings.n["gT"] then lsp_mappings.n["gT"][1] = "<CMD>Lspsaga goto_type_definition<CR>" end
  end

  if is_available "telescope.nvim" then -- setup telescope mappings if available
    if lsp_mappings.n["<leader>ls"] then lsp_mappings.n["<leader>ls"][1] = "<CMD>Telescope document_symbol<CR>" end
    if lsp_mappings.n["<leader>lc"] then lsp_mappings.n["<leader>lc"][1] = "<CMD>Telescope lsp_incoming_calls<CR>" end
    if lsp_mappings.n["<leader>lC"] then lsp_mappings.n["<leader>lC"][1] = "<CMD>Telescope lsp_outgoing_calls<CR>" end
    if lsp_mappings.n["gd"] then lsp_mappings.n["gd"][1] = "<CMD>Telescope lsp_definitions<CR>" end
    if lsp_mappings.n["gI"] then lsp_mappings.n["gI"][1] = "<CMD>Telescope lsp_implementations<CR>" end
    if lsp_mappings.n["gr"] then lsp_mappings.n["gr"][1] = "<CMD>Telescope lsp_references<CR>" end
    if lsp_mappings.n["<leader>lR"] then lsp_mappings.n["<leader>lR"][1] = "<CMD>Telescope lsp_references<CR>" end
    if lsp_mappings.n["gT"] then lsp_mappings.n["gT"][1] = "<CMD>Telescope lsp_type_definitions<CR>" end
  end

  if not vim.tbl_isempty(lsp_mappings.v) then
    lsp_mappings.n["<leader>l"] = map():buffer(bufnr):desc(wk_icons.l)
  end

  keymap_utils.load_keymaps(lsp_mappings)
end

--- The lsp capabilities to be used by lspconfig
function Config.capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  if is_available("nvim-ufo") then
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }
  end
  return capabilities
end

return Config
