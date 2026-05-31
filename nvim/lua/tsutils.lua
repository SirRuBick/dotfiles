-- Tree-sitter parser management
-- Provides :TSInstall, :TSInstallAll, :TSUninstall, :TSInfo commands
-- Requires: git, tree-sitter CLI, gcc (or cc/clang) in PATH

local M = {}

-- Grammar registry (language -> repo URL)
M.grammars = {
  bash = "https://github.com/tree-sitter/tree-sitter-bash",
  c = "https://github.com/tree-sitter/tree-sitter-c",
  c_sharp = "https://github.com/tree-sitter/tree-sitter-c-sharp",
  comment = "https://github.com/tree-sitter-grammars/tree-sitter-comment",
  cpp = "https://github.com/tree-sitter/tree-sitter-cpp",
  css = "https://github.com/tree-sitter/tree-sitter-css",
  csv = "https://github.com/tree-sitter-grammars/tree-sitter-csv",
  diff = "https://github.com/tree-sitter-grammars/tree-sitter-diff",
  gitignore = "https://github.com/shunsambon/tree-sitter-gitignore",
  html = "https://github.com/tree-sitter/tree-sitter-html",
  http = "https://github.com/NTBBloodbath/tree-sitter-http",
  json = "https://github.com/tree-sitter/tree-sitter-json",
  kdl = "https://github.com/tree-sitter-grammars/tree-sitter-kdl",
  lua = "https://github.com/tree-sitter-grammars/tree-sitter-lua",
  luadoc = "https://github.com/tree-sitter-grammars/tree-sitter-lua",
  luap = "https://github.com/tree-sitter-grammars/tree-sitter-lua",
  markdown = "https://github.com/tree-sitter-grammars/tree-sitter-markdown",
  markdown_inline = "https://github.com/tree-sitter-grammars/tree-sitter-markdown",
  python = "https://github.com/tree-sitter/tree-sitter-python",
  regex = "https://github.com/tree-sitter/tree-sitter-regex",
  rust = "https://github.com/tree-sitter/tree-sitter-rust",
  sql = "https://github.com/DerekStride/tree-sitter-sql",
  toml = "https://github.com/ikatyang/tree-sitter-toml",
  tsx = "https://github.com/tree-sitter/tree-sitter-typescript",
  xml = "https://github.com/tree-sitter-grammars/tree-sitter-xml",
  yaml = "https://github.com/ikatyang/tree-sitter-yaml",
}

-- Multi-parser repos: language -> subdirectory within the cloned repo
M.subdir = {
  luadoc = "luadoc",
  luap = "luap",
  markdown_inline = "tree-sitter-markdown-inline",
  tsx = "tsx",
}

local parser_dir = vim.fn.stdpath("config") .. "/parser"

-- Detect available C compiler
local function find_compiler()
  for _, cc in ipairs({ "gcc", "cc", "clang" }) do
    if vim.fn.executable(cc) == 1 then
      return cc
    end
  end
  return nil
end

--- Build and install a single parser
function M.install(lang)
  local repo = M.grammars[lang]
  if not repo then
    vim.notify("Unknown language: " .. lang, vim.log.levels.ERROR)
    return false
  end

  if vim.fn.executable("git") ~= 1 then
    vim.notify("git not found in PATH", vim.log.levels.ERROR)
    return false
  end

  if vim.fn.executable("tree-sitter") ~= 1 then
    vim.notify("tree-sitter CLI not found in PATH", vim.log.levels.ERROR)
    return false
  end

  local cc = find_compiler()
  if not cc then
    vim.notify("No C compiler found (gcc, cc, clang)", vim.log.levels.ERROR)
    return false
  end

  vim.notify("Building " .. lang .. "...", vim.log.levels.INFO)

  local tmp = vim.fn.tempname() .. "_" .. lang
  vim.fn.mkdir(tmp, "p")

  local subdir = M.subdir[lang]
  local src_dir = subdir and (tmp .. "/" .. subdir) or tmp

  -- Clone grammar repo
  local clone = vim.system({ "git", "clone", "--depth", "1", repo, tmp }):wait()
  if clone.code ~= 0 then
    vim.notify("Failed to clone " .. lang, vim.log.levels.ERROR)
    vim.fn.delete(tmp, "rf")
    return false
  end

  -- Generate parser C code from grammar.js
  local grammar_js = src_dir .. "/grammar.js"
  if vim.fn.filereadable(grammar_js) == 1 then
    local gen = vim.system({ "tree-sitter", "generate" }, { cwd = src_dir }):wait()
    if gen.code ~= 0 then
      vim.notify("Failed to generate grammar for " .. lang, vim.log.levels.ERROR)
      vim.fn.delete(tmp, "rf")
      return false
    end
  end

  -- Locate parser source
  local parser_c = src_dir .. "/src/parser.c"
  if vim.fn.filereadable(parser_c) ~= 1 then
    vim.notify("No parser.c found for " .. lang, vim.log.levels.ERROR)
    vim.fn.delete(tmp, "rf")
    return false
  end

  -- Check for optional scanner
  local scanner_cc = src_dir .. "/src/scanner.cc"
  local scanner_c = src_dir .. "/src/scanner.c"
  local scanner = nil
  local linker = cc
  if vim.fn.filereadable(scanner_cc) == 1 then
    scanner = scanner_cc
    linker = "g++"
  elseif vim.fn.filereadable(scanner_c) == 1 then
    scanner = scanner_c
  end

  -- Compile shared library
  vim.fn.mkdir(parser_dir, "p")
  local output = parser_dir .. "/" .. lang .. ".so"
  local is_win = vim.fn.has("win32") == 1
  local cflags = { "-shared", "-O2" }
  if not is_win then
    table.insert(cflags, "-fPIC")
  end
  table.insert(cflags, "-I")
  table.insert(cflags, src_dir .. "/src")
  table.insert(cflags, "-o")
  table.insert(cflags, output)
  table.insert(cflags, parser_c)
  if scanner then
    table.insert(cflags, scanner)
  end

  local build = vim.system({ linker, table.unpack(cflags) }):wait()
  vim.fn.delete(tmp, "rf")

  if build.code == 0 then
    vim.notify("Built " .. lang, vim.log.levels.INFO)
    return true
  else
    vim.notify("Failed to build " .. lang, vim.log.levels.ERROR)
    return false
  end
end

--- Delete a parser
function M.uninstall(lang)
  local path = parser_dir .. "/" .. lang .. ".so"
  if vim.fn.filereadable(path) == 1 then
    vim.fn.delete(path)
    vim.notify("Removed " .. lang, vim.log.levels.INFO)
  else
    vim.notify("Parser not found: " .. lang, vim.log.levels.WARN)
  end
end

--- Check if a parser is installed
function M.is_installed(lang)
  return vim.fn.filereadable(parser_dir .. "/" .. lang .. ".so") == 1
end

--- Show parser status in a floating window
function M.info()
  local installed = {}
  local not_installed = {}
  for lang, _ in vim.spairs(M.grammars) do
    if M.is_installed(lang) then
      table.insert(installed, lang)
    else
      table.insert(not_installed, lang)
    end
  end
  table.sort(installed)
  table.sort(not_installed)

  local lines = {}
  table.insert(lines, "Installed (" .. #installed .. "):")
  for _, lang in ipairs(installed) do
    table.insert(lines, "  " .. lang)
  end
  table.insert(lines, "")
  table.insert(lines, "Not installed (" .. #not_installed .. "):")
  for _, lang in ipairs(not_installed) do
    table.insert(lines, "  " .. lang)
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].buftype = "nofile"

  local height = math.min(#lines, vim.o.lines - 4)
  vim.api.nvim_open_win(buf, true, {
    relative = "cursor",
    width = 40,
    height = height,
    row = 1,
    col = 0,
    style = "minimal",
    border = "rounded",
    focusable = true,
  })
end

-- Tab completion: all available languages
local function complete_all(arg_lead)
  local candidates = {}
  for lang, _ in pairs(M.grammars) do
    if lang:find(arg_lead, 1, true) then
      table.insert(candidates, lang)
    end
  end
  table.sort(candidates)
  return candidates
end

-- Tab completion: only installed languages
local function complete_installed(arg_lead)
  local candidates = {}
  for lang, _ in pairs(M.grammars) do
    if M.is_installed(lang) and lang:find(arg_lead, 1, true) then
      table.insert(candidates, lang)
    end
  end
  table.sort(candidates)
  return candidates
end

-- User commands
vim.api.nvim_create_user_command("TSInstall", function(opts)
  for _, lang in ipairs(vim.split(opts.args, "%s+", { trimempty = true })) do
    M.install(lang)
  end
end, {
  nargs = "+",
  complete = function(arg_lead) return complete_all(arg_lead) end,
  desc = "Install tree-sitter parser(s)",
})

vim.api.nvim_create_user_command("TSInstallAll", function()
  local langs = vim.tbl_keys(M.grammars)
  table.sort(langs)
  for _, lang in ipairs(langs) do
    M.install(lang)
  end
end, {
  desc = "Install all tree-sitter parsers",
})

vim.api.nvim_create_user_command("TSUninstall", function(opts)
  for _, lang in ipairs(vim.split(opts.args, "%s+", { trimempty = true })) do
    M.uninstall(lang)
  end
end, {
  nargs = "+",
  complete = function(arg_lead) return complete_installed(arg_lead) end,
  desc = "Uninstall tree-sitter parser(s)",
})

vim.api.nvim_create_user_command("TSInfo", function()
  M.info()
end, {
  desc = "Show tree-sitter parser status",
})

return M
