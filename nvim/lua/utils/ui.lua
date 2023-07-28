local M = {}

local function bool2str(bool) return bool and "on" or "off" end


--- Toggle autopairs
function M.toggle_autopairs()
  local ok, autopairs = pcall(require, "nvim-autopairs")
  if ok then
    if autopairs.state.disabled then
      autopairs.enable()
    else
      autopairs.disable()
    end
    vim.g.autopairs_enabled = autopairs.state.disabled
    vim.notify(string.format("autopairs %s", bool2str(not autopairs.state.disabled)))
  else
    vim.notify("autopairs not available")
  end
end

--- Toggle diagnostics
local virtual_text = true
function M.toggle_diagnostics()
  virtual_text = not virtual_text
  vim.diagnostic.config({ virtual_text = virtual_text })
  vim.notify(string.format("diagnostics virtual text %s", bool2str(virtual_text)))
end

--- Toggle cmp entrirely
function M.toggle_cmp()
  vim.b.cmp_enabled = not vim.b.cmp_enabled
  require("cmp").setup.buffer { enabled = vim.b.cmp_enabled }
  vim.notify(string.format("completion %s", bool2str(vim.b.cmp_enabled)))
end

--- Toggle codelens
function M.toggle_codelens()
  vim.g.codelens_enabled = not vim.g.codelens_enabled
  if not vim.g.codelens_enabled then vim.lsp.codelens.clear() end
  vim.notify(string.format("CodeLens %s", bool2str(vim.g.codelens_enabled)))
end

--- Toggle conceal=2|0
function M.toggle_conceal()
  vim.opt.conceallevel = vim.opt.conceallevel:get() == 0 and 2 or 0
  vim.notify(string.format("conceal %s", bool2str(vim.opt.conceallevel:get() == 2)))
end

--- Toggle laststatus=3|2|0
function M.toggle_statusline()
  local laststatus = vim.opt.laststatus:get()
  local status
  if laststatus == 0 then
    vim.opt.laststatus = 2
    status = "local"
  elseif laststatus == 2 then
    vim.opt.laststatus = 3
    status = "global"
  elseif laststatus == 3 then
    vim.opt.laststatus = 0
    status = "off"
  end
  vim.notify(string.format("statusline %s", status))
end

--- Toggle spell
function M.toggle_spell()
  vim.wo.spell = not vim.wo.spell -- local to window
  vim.notify(string.format("spell %s", bool2str(vim.wo.spell)))
end

--- Toggle wrap
function M.toggle_wrap()
  vim.wo.wrap = not vim.wo.wrap -- local to window
  vim.notify(string.format("wrap %s", bool2str(vim.wo.wrap)))
end

return M
