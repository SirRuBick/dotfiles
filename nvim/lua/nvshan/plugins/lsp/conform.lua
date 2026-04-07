-- define custom formatter
local formatters = {}

formatters.black = {
  prepand_args = {
    "--line-length=120",
  },
}

formatters.isort = {
  prepend_args = {
    "--line-length=119",
  },
}

-- set up conform
require("conform").setup({
  -- Map of filetype to formatters
  formatters_by_ft = {
    lua = { "stylua" },
    python = function(bufnr)
      if require("conform").get_formatter_info("ruff_format", bufnr).available then
        return { "ruff_format" }
      else
        return { "black", "isort" }
      end
    end,
    c = { "clang-format" },
    cpp = { "clang-format" },
    sh = { "shellcheck" },
    -- Use the "*" filetype to run formatters on all filetypes.
    -- ["*"] = { "codespell" },
    -- Use the "_" filetype to run formatters on filetypes that don't
    -- have other formatters configured.
    -- ["_"] = { "trim_whitespace" },
  },
  -- custom formatters or overwrite default ones
  formatters = formatters,
})

local registry = require("mason-registry")
local all_formatters = require("conform").list_all_formatters()
local ensure_installed = {}

for i, v in pairs(all_formatters) do
  table.insert(ensure_installed, v.name)
end

-- Ensure packages are installed and up to date
registry.refresh(function()
  for _, name in pairs(ensure_installed) do
    local package = registry.get_package(name)
    if not registry.is_installed(name) then
      package:install()
      vim.notify(name .. " is installed")
    else
      -- package:check_new_version(function(success, result_or_err)
      --   if success then
      --     package:install({ version = result_or_err.latest_version })
      --   end
      -- end)
    end
  end
end)
