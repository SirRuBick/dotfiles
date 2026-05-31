-- Language server configurations
local servers = {
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = { globals = { "vim" } },
        codeLens = { enable = true },
        workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
        hint = {
          enable = true,
          setType = false,
          paramType = true,
          paramName = "Disable",
          semicolon = "Disable",
          arrayIndex = "Disable",
        },
      },
    },
  },
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        check = { command = "clippy", onSave = true },
        inlayHints = {
          chainingHints = { enable = true },
          enable = true,
          parameterHints = { enable = true },
          typeHints = { enable = true },
        },
      },
    },
  },
  pyright = {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
          autoSearchPaths = true,
          diagnosticMode = "openFilesOnly",
          useLibraryCodeForTypes = true,
        },
      },
    },
    single_file_support = true,
  },
  clangd = {
    cmd = { "clangd", "--offset-encoding=utf-16" },
  },
  bashls = {},
  ts_ls = {},
  jsonls = {},
  sqlls = {},
}

return servers
