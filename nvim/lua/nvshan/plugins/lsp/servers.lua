-- ### server configs for LSP
--
-- some configurations for lsp
-- -- find more on https://github.com/williamboman/mason-lspconfig.nvim
--
-- @Author: alex shan
-- @Date:   2023
--
return {
  -- CMAKE
  cmake = {},

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

  -- lATEX; MARKDOWN
  ltex = {
    cmd = { "ltex-ls" },
    filetypes = { "bib", "gitcommit", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc", "quarto", "rmd" },
    single_file_support = true,
    settings = {
      ltex = { language = "en" },
    },
  },

  -- LUA
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        completion = {
          callSnippet = "Replace"
        }
      }
    }
  },


  -- MARKDOWN
  marksman = {},

  -- PYTHON
  pyright = {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "openFilesOnly",
          useLibraryCodeForTypes = true
        }
      }
    },
    single_file_support = true,
  },

  -- SQL
  sqlls = {},
}
