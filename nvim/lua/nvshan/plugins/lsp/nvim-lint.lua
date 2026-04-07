-- setup nvim-lint
local lint = require("lint")
lint.linters_by_ft = {
  python = { "flake8", "mypy" },
  sh = { "shellcheck" },
}

-- customize flake8
local flake8 = lint.linters.flake8
flake8.args = { "--format=default", "--quiet" }

-- customize mypy
local mypy = lint.linters.mypy
mypy.args = {
  "--follow_imports=normal",
  "--show-column-numbers",
  "--warn-unused-ignores",
  "--warn-return-any",
  "--warn-redundant-casts",
  "--warn-unused-configs",
}

local registry = require("mason-registry")
local ensure_installed = {}

for _, linters in pairs(lint.linters_by_ft) do
  vim.list_extend(ensure_installed, linters)
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
