-- ### server configs for LSP
--
-- some key mapping for neovim
-- find more on https://github.com/williamboman/mason-lspconfig.nvim
--
-- @Author: alex shan
-- @Date:   2023
--
return {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  pyright = {},
  jsonls = {},
  marksman = {},
  dockerls = {},
  docker_compose_language_service = {},
  bashls = {},
}

