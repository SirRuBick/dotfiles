local Config = {}

local is_available = require("utils").is_available
local settings = require("settings")
local keymap_utils = require("nvshan.keymap.utils")
local map = keymap_utils.map
local wk_icons = require("icons").whichkey

--- The `on_attach` function used by lspconfig
---@param client table The LSP client details when attaching
---@param bufnr number The buffer that the LSP client is attaching to
Config.on_attach = function(client, bufnr)
  -- keymaps
  local capabilities = client.server_capabilities
  local lsp_mappings = keymap_utils.init_mapping()

  lsp_mappings.n["<leader>l"] = map():buffer(bufnr):desc(wk_icons.l)
  lsp_mappings.v["<leader>l"] = map():buffer(bufnr):desc(wk_icons.l)

  if is_available("mason-lspconfig.nvim") then
    lsp_mappings.n["<leader>lz"] = map("<cmd>LspInfo<CR>"):buffer(bufnr):desc("LSP information")
    lsp_mappings.n["<leader>lZ"] = map("<cmd>LspRestart<CR>"):buffer(bufnr):desc("LSP Restart")
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
    lsp_mappings.n["<leader>lp"] = map(vim.lsp.buf.hover):buffer(bufnr):desc("Peek symbol definition")
  end
  if capabilities.codeActionProvider then
    lsp_mappings.n["<leader>la"] = map(vim.lsp.buf.code_action):buffer(bufnr):desc("LSP code action")
    lsp_mappings.v["<leader>la"] = map(vim.lsp.buf.code_action):buffer(bufnr):desc("LSP code action")
  end
  if capabilities.definitionProvider then
    lsp_mappings.n["gd"] = map(vim.lsp.buf.definition):buffer(bufnr):desc("Show the definition of current symbol")
  end
  if capabilities.typeDefinitionProvider then
    lsp_mappings.n["gt"] = map(vim.lsp.buf.type_definition):buffer(bufnr):desc("Definition of current type")
  end

  if capabilities.declarationProvider then
    lsp_mappings.n["gD"] = map(vim.lsp.buf.declaration):buffer(bufnr):desc("Declaration of current symbol")
  end
  if capabilities.signatureHelpProvider then
    lsp_mappings.n["<leader>lh"] = map(vim.lsp.buf.signature_help):buffer(bufnr):desc("Signature help")
  end
  if capabilities.documentFormattingProvider then
    lsp_mappings.n["<leader>lf"] = map(vim.lsp.buf.format):buffer(bufnr):desc("Format buffer with lsp")
    local status_ok, lsp_fm = pcall(require, "lsp-format-modifications")
    if status_ok then
      lsp_mappings.n["<leader>lF"] = map(function()
          lsp_fm.format_modifications(client, bufnr)
        end)
        :buffer(bufnr)
        :desc("Format modifications only")
    end
  end
  if capabilities.implementationProvider then
    lsp_mappings.n["gI"] = map(vim.lsp.buf.implementation):buffer(bufnr):desc("Implementation of current symbol")
  end
  if capabilities.referencesProvider then
    lsp_mappings.n["<leader>lr"] = map(vim.lsp.buf.references):buffer(bufnr):desc("References of current symbol")
  end
  if capabilities.callHierarchyProvider then
    lsp_mappings.n["<leader>lc"] = map(vim.lsp.buf.incoming_calls):buffer(bufnr):desc("Show incoming calls")
    lsp_mappings.n["<leader>lC"] = map(vim.lsp.buf.outgoing_calls):buffer(bufnr):desc("Show outgoing calls")
  end
  if capabilities.workspaceSymbolProvider then
    lsp_mappings.n["<leader>lS"] = map(vim.lsp.buf.workspace_symbol):buffer(bufnr):desc("List all workspace symbols")
  end
  lsp_mappings.n["<leader>lw"] = map(vim.lsp.buf.add_workspace_folder):buffer(bufnr):desc("Add workspace folder")
  lsp_mappings.n["<leader>lW"] = map(vim.lsp.buf.list_workspace_folders):buffer(bufnr):desc("List workspace folder")
  -- from plugins
  if is_available("nvim-lint") then
    local lint = require("lint")
    lsp_mappings.n["<leader>ll"] = map(function()
        lint.try_lint()
      end)
      :buffer(bufnr)
      :desc("Lint")
    lsp_mappings.n["<leader>lL"] = map(function()
        vim.ui.input({ "prompt = Lint options:" }, function(input)
          lint.try_lint(input)
        end)
      end)
      :buffer(bufnr)
      :desc("Lint with options")
  end

  if is_available("nvim-navbuddy") then
    lsp_mappings.n["<leader>ln"] = map("<cmd>Navbuddy<CR>"):buffer(bufnr):desc("Navbuddy")
  end

  if is_available("outline.nvim") then
    lsp_mappings.n["<leader>lo"] = map("<CMD>Outline<CR>"):buffer(bufnr):desc("Show outline")
  end

  -- Lspsaga overrides
  if is_available("lspsaga.nvim") then
    -- lsp saga specific keymaps
    lsp_mappings.n["<leader>lo"] = map("<CMD>Lspsaga outline<CR>"):buffer(bufnr):desc("Show outline")
    -- other keymaps
    if lsp_mappings.n["<leader>lc"] then
      lsp_mappings.n["<leader>lc"] = map("<CMD>Lspsaga incoming_calls<CR>"):buffer(bufnr):desc("Show incoming calls")
    end
    if lsp_mappings.n["<leader>lC"] then
      lsp_mappings.n["<leader>lC"] = map("<CMD>Lspsaga outgoing_calls<CR>"):buffer(bufnr):desc("Show outgoing calls")
    end
    if lsp_mappings.n["[d"] then
      lsp_mappings.n["[d"].rhs = "<CMD>Lspsaga diagnostic_jump_prev<CR>"
    end
    if lsp_mappings.n["]d"] then
      lsp_mappings.n["]d"].rhs = "<CMD>Lspsaga diagnostic_jump_next<CR>"
    end
    if lsp_mappings.n["<leader>ld"] then
      lsp_mappings.n["<leader>ld"].rhs = "<CMD>Lspsaga show_line_diagnostics<CR>"
    end
    if lsp_mappings.n["<leader>lr"] then
      lsp_mappings.n["<leader>lr"].rhs = "<CMD>Lspsaga rename<CR>"
    end
    if lsp_mappings.n["<leader>lp"] then
      lsp_mappings.n["<leader>lp"].rhs = "<CMD>Lspsaga peek_definition<CR>"
    end
    if lsp_mappings.n["<leader>la"] then
      lsp_mappings.n["<leader>la"].rhs = "<CMD>Lspsaga code_action<CR>"
    end
    if lsp_mappings.v["<leader>la"] then
      lsp_mappings.v["<leader>la"].rhs = "<CMD>Lspsaga code_action<CR>"
    end
    if lsp_mappings.n["gd"] then
      lsp_mappings.n["gd"].rhs = "<CMD>Lspsaga goto_definition<CR>"
    end
    if lsp_mappings.n["gT"] then
      lsp_mappings.n["gT"].rhs = "<CMD>Lspsaga goto_type_definition<CR>"
    end
  end

  -- Telescope overrides
  if is_available("telescope.nvim") then -- setup telescope mappings if available
    if lsp_mappings.n["<leader>ls"] then
      lsp_mappings.n["<leader>ls"].rhs = "<CMD>Telescope lsp_document_symbols<CR>"
    end
    if lsp_mappings.n["<leader>lc"] then
      lsp_mappings.n["<leader>lc"].rhs = "<CMD>Telescope lsp_incoming_calls<CR>"
    end
    if lsp_mappings.n["<leader>lC"] then
      lsp_mappings.n["<leader>lC"].rhs = "<CMD>Telescope lsp_outgoing_calls<CR>"
    end
    if lsp_mappings.n["gd"] then
      lsp_mappings.n["gd"].rhs = "<CMD>Telescope lsp_definitions<CR>"
    end
    if lsp_mappings.n["gI"] then
      lsp_mappings.n["gI"].rhs = "<CMD>Telescope lsp_implementations<CR>"
    end
    if lsp_mappings.n["<leader>lr"] then
      lsp_mappings.n["<leader>lr"].rhs = "<CMD>Telescope lsp_references<CR>"
    end
    if lsp_mappings.n["gT"] then
      lsp_mappings.n["gT"].rhs = "<CMD>Telescope lsp_type_definitions<CR>"
    end
    lsp_mappings.n["<leader>lD"] = map(function()
        require("telescope.builtin").diagnostics()
      end)
      :silent()
      :desc("Search diagnostics")
  end

  if not vim.tbl_isempty(lsp_mappings.v) then
    lsp_mappings.n["<leader>l"] = map():buffer(bufnr):desc(wk_icons.l)
  end

  if is_available("conform.nvim") then
    local conform = require("conform")
    local buf_table = conform.list_formatters_for_buffer(bufnr)
    if buf_table then
      lsp_mappings.n["<leader>lf"] = map(function()
          conform.format({ async = true, lsp_fallback = true })
        end)
        :buffer(bufnr)
        :desc("Format buffer with conform")
    end
  end

  if is_available("lsp_signature.nvim") then
    require("lsp_signature").on_attach({
      bind = true,
      handler_opts = { border = "rounded" },
    }, bufnr)
  end

  keymap_utils.load_keymaps(lsp_mappings)
end

--- The lsp capabilities to be used by lspconfig
function Config.capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.preselectSupport = true

  if is_available("nvim-ufo") then
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }
  end

  -- set lsp virtual text based on settings.diagnostic_virtual_text
  vim.diagnostic.config({ virtual_text = settings.diagnostic_virtual_text })

  return capabilities
end

return Config
