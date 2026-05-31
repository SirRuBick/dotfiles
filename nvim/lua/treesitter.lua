-- nvim/lua/core/treesitter.lua
-- Built-in treesitter config — no nvim-treesitter plugin needed
-- Requires parsers in nvim/parser/ (or built-in)

local ts = vim.treesitter
local api = vim.api

-- ── Parser languages ────────────────────────────────────────────────────────
local highlight_langs = {
  "bash", "c", "c_sharp", "comment", "cpp", "css", "csv", "diff",
  "html", "http", "json", "kdl", "lua", "luadoc", "luap",
  "markdown", "markdown_inline", "python", "query", "regex",
  "rust", "sql", "toml", "tsx", "vim", "vimdoc", "xml", "yaml",
}

-- ── Highlighting ────────────────────────────────────────────────────────────
api.nvim_create_autocmd("FileType", {
  pattern = highlight_langs,
  callback = function(args)
    pcall(ts.start, { bufnr = args.buf })
  end,
  desc = "Enable treesitter highlighting",
})

-- ── Helper: get node range ──────────────────────────────────────────────────
local function node_range(node)
  local sr, sc, er, ec = node:range()
  return sr, sc, er, ec
end

-- ── Helper: select node visually ────────────────────────────────────────────
local function select_node(node)
  local sr, sc, er, ec = node_range(node)
  local line_count = api.nvim_buf_line_count(0)
  if sr >= line_count then return end
  if er >= line_count then
    er = line_count - 1
    ec = math.huge
  end
  api.nvim_win_set_cursor(0, { sr + 1, sc })
  vim.cmd("normal! v")
  api.nvim_win_set_cursor(0, { er + 1, ec })
end

-- ── Helper: walk up tree to find node type ──────────────────────────────────
local function find_ancestor(node, type_list)
  local current = node
  while current do
    if vim.tbl_contains(type_list, current:type()) then
      return current
    end
    current = current:parent()
  end
  return nil
end

-- ── Node types for text objects ─────────────────────────────────────────────
local function_types = {
  "function_definition", "function_declaration", "method_definition",
  "method_declaration", "function_item", "function",
  "arrow_function", "function_expression",
}

local class_types = {
  "class_definition", "class_declaration", "struct_item",
  "impl_item", "class", "struct", "enum",
}

local parameter_types = {
  "parameters", "arguments", "parameter_list", "argument_list",
  "formal_parameters", "argument_list",
}

local conditional_types = {
  "if_statement", "elif_clause", "else_clause", "match_statement",
  "conditional_expression", "switch_expression",
}

local loop_types = {
  "for_statement", "while_statement", "for_in_clause",
  "do_statement", "for_expression",
}

local assignment_types = {
  "assignment", "assignment_statement", "augmented_assignment",
  "variable_declaration", "let_declaration",
}

local scope_types = {
  "block", "module", "chunk", "source_file", "program",
}

-- ── Text objects (all in visual + operator-pending mode) ────────────────────
local textobject_map = {
  { "af", function_types, false },
  { "if", function_types, true },
  { "ac", class_types, false },
  { "ic", class_types, true },
  { "aa", parameter_types, false },
  { "ia", parameter_types, true },
  { "ai", conditional_types, false },
  { "ii", conditional_types, true },
  { "ay", loop_types, false },
  { "iy", loop_types, true },
  { "a=", assignment_types, false },
  { "i=", assignment_types, true },
  { "as", scope_types, false },
  { "is", scope_types, true },
}

for _, map in ipairs(textobject_map) do
  local lhs, type_list, is_inner = map[1], map[2], map[3]

  local function do_textobject()
    local parser = ts.get_parser()
    if not parser then return end
    local tree = parser:trees()[1]
    if not tree then return end
    local root = tree:root()
    local cursor = api.nvim_win_get_cursor(0)
    local row, col = cursor[1] - 1, cursor[2]

  local node = root:named_descendant_for_range(row, col, row, col)
  if not node then return end
  local target = find_ancestor(node, type_list)
    if target then
      if is_inner then
        -- Inner: skip first and last named children (braces, keywords)
        local first = target:named_child(0)
        local last = target:named_child(target:named_child_count() - 1)
        if first and last and first ~= last then
          local sr, sc = first:range()
          local _, _, er, ec = last:range()
          api.nvim_win_set_cursor(0, { sr + 1, sc })
          vim.cmd("normal! v")
          api.nvim_win_set_cursor(0, { er + 1, ec })
          return
        end
      end
      select_node(target)
    end
  end

  vim.keymap.set("x", lhs, do_textobject, { desc = "TS " .. lhs })
  vim.keymap.set("o", lhs, function()
    vim.cmd("normal! v")
    do_textobject()
  end, { desc = "TS " .. lhs })
end

-- ── Peek definition ─────────────────────────────────────────────────────────
vim.keymap.set("n", "<leader>lp", function()
  local params = vim.lsp.util.make_position_params()
  vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result)
    if not result or #result == 0 then return end
    local target = result[1]
    local uri = target.uri or target.targetUri
    local range = target.range or target.targetSelectionRange
    local bufnr = vim.uri_to_bufnr(uri)
    -- Ensure buffer is loaded
    if not api.nvim_buf_is_loaded(bufnr) then
      vim.fn.bufload(bufnr)
    end
    local lines = api.nvim_buf_get_lines(bufnr, range.start.line, range["end"].line + 1, false)
    local width = 0
    for _, line in ipairs(lines) do
      width = math.max(width, #line)
    end
    api.nvim_open_win(bufnr, false, {
      relative = "cursor",
      width = math.min(width + 2, vim.o.columns - 4),
      height = #lines,
      row = 1,
      col = 0,
      style = "minimal",
      border = "rounded",
      focusable = false,
    })
  end)
end, { desc = "Peek definition" })
