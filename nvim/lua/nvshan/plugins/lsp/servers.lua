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
  cmake = {
    cmd = { "cmake-language-server" },
    filetypes = { "cmake" },
    init_options = {
      buildDirectory = "build",
      maxThreads = 4,
    },
    root_dir = require("lspconfig/util").root_pattern("CMakePresets.json", "CTestConfig.cmake", ".git", "build", "cmake"),
    single_file_support = true,
  },

  -- C/C++
  clangd = {
    cmd = { "cland" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    root_dir = require("lspconfig/util").root_pattern(
      ".clangd",
      ".clang-tidy",
      ".clang-format",
      "compile_commands.json",
      "compile_flags.txt",
      "configure.ac",
      ".git"
    ),
    flags = {
      debounce_text_changes = 500,
    },
    single_file_support = true,
  },

  -- -- C SHARP
  -- csharp_ls = {
  --   cmd = { "csharp-ls" },
  --   filetypes = { "cs" },
  --   init_options = { AutomaticWorkspaceInit = true },
  -- },

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
