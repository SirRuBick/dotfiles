return function(_, _)
  local icons = require("icons")
  local signs = {
    { name = "DiagnosticSignError",    text = icons.diagnostics.Error,       texthl = "DiagnosticSignError" },
    { name = "DiagnosticSignWarn",     text = icons.diagnostics.Warning,     texthl = "DiagnosticSignWarn" },
    { name = "DiagnosticSignHint",     text = icons.diagnostics.Hint,        texthl = "DiagnosticSignHint" },
    { name = "DiagnosticSignInfo",     text = icons.diagnostics.Information, texthl = "DiagnosticSignInfo" },
    { name = "DapStopped",             text = icons.dap.Stopped,             texthl = "DiagnosticWarn" },
    { name = "DapBreakpoint",          text = icons.dap.Breakpoint,          texthl = "DiagnosticInfo" },
    { name = "DapBreakpointRejected",  text = icons.dap.BreakpointRejected,  texthl = "DiagnosticError" },
    { name = "DapBreakpointCondition", text = icons.dap.BreakpointCondition, texthl = "DiagnosticInfo" },
    { name = "DapLogPoint",            text = icons.dap.LogPoint,            texthl = "DiagnosticInfo" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, sign)
  end

  local config = {
    signs = {
      active = signs, -- show signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  if vim.g.lsp_handlers_enabled then
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", silent = true })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
      { border = "rounded", silent = true })
  end
end
