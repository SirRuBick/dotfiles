-- ### server configs for LSP
--
-- some configurations for lsp
-- -- find more on https://github.com/williamboman/mason-lspconfig.nvim
--
-- @Author: alex shan
-- @Date:   2023
--
return {
  -- Bash
  bashls = {},

  -- C/C++
  clangd = {
    cmd = {
      "clangd",
      "--offset-encoding=utf-16",
    },
  },

  -- -- C SHARP
  -- csharp_ls = {},

  -- DOCKER
  dockerls = {},

  -- HTML
  html = {},

  -- JSON
  jsonls = {},

  -- LUA
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  },

  -- RUST
  -- more configurations: https://github.com/rust-lang/rust-analyzer/blob/4981f00bb6a9f677b5a139e3749c4942175d6751/docs/user/generated_config.adoc
  rust_analyzer = {
    diagnostics = { enabled = true },
  },

  -- PYTHON
  pyright = {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "openFilesOnly",
          useLibraryCodeForTypes = true,
        },
      },
    },
    single_file_support = true,
  },

  -- SQL
  sqlls = {},
}
