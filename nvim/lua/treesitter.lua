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

local call_types = {
  "call", "call_expression", "function_call", "method_call",
  "macro_invocation",
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
  { "al", loop_types, false },
  { "il", loop_types, true },
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

-- ── Incremental selection ───────────────────────────────────────────────────
vim.keymap.set({ "n", "x" }, "<CR>", function()
  local parser = ts.get_parser()
  if not parser then return end
  local tree = parser:trees()[1]
  if not tree then return end
  local root = tree:root()
  local cursor = api.nvim_win_get_cursor(0)
  local row, col = cursor[1] - 1, cursor[2]

  local node = root:named_descendant_for_range(row, col, row, col)
  local parent = node and node:parent() or nil
  if parent then
    select_node(parent)
  end
end, { desc = "TS select grow" })

vim.keymap.set("x", "<BS>", function()
  local parser = ts.get_parser()
  if not parser then return end
  local tree = parser:trees()[1]
  if not tree then return end
  local root = tree:root()
  local cursor = api.nvim_win_get_cursor(0)
  local row, col = cursor[1] - 1, cursor[2]

  local node = root:named_descendant_for_range(row, col, row, col)
  local child = node and node:child(0) or nil
  if child then
    select_node(child)
  end
end, { desc = "TS select shrink" })

-- ── Movement ────────────────────────────────────────────────────────────────
-- Check if a type is a container type (parameters, arguments, etc.)
local container_types = {
  "parameters", "arguments", "parameter_list", "argument_list",
  "formal_parameters",
}

local function is_container(type_name)
  return vim.tbl_contains(container_types, type_name)
end

local function ts_move(direction, type_list)
  local parser = ts.get_parser()
  if not parser then return end
  local tree = parser:trees()[1]
  if not tree then return end
  local root = tree:root()
  local cursor = api.nvim_win_get_cursor(0)
  local row, col = cursor[1] - 1, cursor[2]

  local node = root:named_descendant_for_range(row, col, row, col)
  local target = find_ancestor(node, type_list)

  if target then
    -- If target is a container (parameters/arguments), move between its children
    if is_container(target:type()) then
      local last_before = nil
      for child in target:iter_children() do
        if child:named() then
          local sr, sc, er, ec = child:range()
          if direction == "next" then
            if sr > row or (sr == row and sc > col) then
              api.nvim_win_set_cursor(0, { sr + 1, sc })
              return
            end
          else
            if er < row or (er == row and ec <= col) then
              last_before = child
            end
          end
        end
      end
      if direction == "prev" and last_before then
        local sr, sc = last_before:range()
        api.nvim_win_set_cursor(0, { sr + 1, sc })
      end
      return
    end

    -- Not a container — search siblings
    local search = direction == "next" and target:next_named_sibling() or target:prev_named_sibling()
    while search do
      if vim.tbl_contains(type_list, search:type()) then
        local sr, sc = search:range()
        api.nvim_win_set_cursor(0, { sr + 1, sc })
        return
      end
      search = direction == "next" and search:next_named_sibling() or search:prev_named_sibling()
    end
  else
    -- Outside any matching node — scan tree from root
    local best_node = nil
    local best_dist = math.huge

    local function walk(n)
      if not n then return end
      local ntype = n:type()
      if vim.tbl_contains(type_list, ntype) then
        if is_container(ntype) then
          -- For containers, find the first/last child
          for child in n:iter_children() do
            if child:named() then
              local sr, sc, er, ec = child:range()
              local dist
              if direction == "next" then
                if sr > row or (sr == row and sc > col) then
                  dist = (sr - row) * 10000 + math.abs(sc - col)
                  if dist < best_dist then
                    best_dist = dist
                    best_node = child
                  end
                  break -- first child after cursor
                end
              else
                if er < row or (er == row and ec <= col) then
                  dist = (row - er) * 10000 + math.abs(ec - col)
                  if dist < best_dist then
                    best_dist = dist
                    best_node = child
                  end
                end
              end
            end
          end
        else
          local sr, sc, er, ec = n:range()
          if direction == "next" then
            if sr > row or (sr == row and sc > col) then
              local dist = (sr - row) * 10000 + math.abs(sc - col)
              if dist < best_dist then
                best_dist = dist
                best_node = n
              end
            end
          else
            if er < row or (er == row and ec <= col) then
              local dist = (row - er) * 10000 + math.abs(ec - col)
              if dist < best_dist then
                best_dist = dist
                best_node = n
              end
            end
          end
        end
      end
      for child in n:iter_children() do
        walk(child)
      end
    end

    walk(root)
    if best_node then
      local sr, sc = best_node:range()
      api.nvim_win_set_cursor(0, { sr + 1, sc })
    end
  end
end

local function ts_move_end(direction, type_list)
  local parser = ts.get_parser()
  if not parser then return end
  local tree = parser:trees()[1]
  if not tree then return end
  local root = tree:root()
  local cursor = api.nvim_win_get_cursor(0)
  local row, col = cursor[1] - 1, cursor[2]

  local node = root:named_descendant_for_range(row, col, row, col)
  local target = find_ancestor(node, type_list)

  if target then
    local search = direction == "next" and target:next_named_sibling() or target:prev_named_sibling()
    while search do
      if vim.tbl_contains(type_list, search:type()) then
        local _, _, er, ec = search:range()
        api.nvim_win_set_cursor(0, { er + 1, ec })
        return
      end
      search = direction == "next" and search:next_named_sibling() or search:prev_named_sibling()
    end
  else
    local best_node = nil
    local best_dist = math.huge

    local function walk(n)
      if not n then return end
      if vim.tbl_contains(type_list, n:type()) then
        local sr, sc, er, ec = n:range()
        if direction == "next" then
          if er > row or (er == row and ec > col) then
            local dist = (er - row) * 10000 + math.abs(ec - col)
            if dist < best_dist then
              best_dist = dist
              best_node = n
            end
          end
        else
          if sr < row or (sr == row and sc <= col) then
            local dist = (row - sr) * 10000 + math.abs(sc - col)
            if dist < best_dist then
              best_dist = dist
              best_node = n
            end
          end
        end
      end
      for child in n:iter_children() do
        walk(child)
      end
    end

    walk(root)
    if best_node then
      local _, _, er, ec = best_node:range()
      api.nvim_win_set_cursor(0, { er + 1, ec })
    end
  end
end

-- Function: ]m/[m = start, ]M/[M = end
vim.keymap.set("n", "]m", function() ts_move("next", function_types) end, { desc = "Next function start" })
vim.keymap.set("n", "[m", function() ts_move("prev", function_types) end, { desc = "Prev function start" })
vim.keymap.set("n", "]M", function() ts_move_end("next", function_types) end, { desc = "Next function end" })
vim.keymap.set("n", "[M", function() ts_move_end("prev", function_types) end, { desc = "Prev function end" })

-- Class: start and end
vim.keymap.set("n", "]]", function() ts_move("next", class_types) end, { desc = "Next class start" })
vim.keymap.set("n", "[[", function() ts_move("prev", class_types) end, { desc = "Prev class start" })
vim.keymap.set("n", "][", function() ts_move_end("next", class_types) end, { desc = "Next class end" })
vim.keymap.set("n", "[]", function() ts_move_end("prev", class_types) end, { desc = "Prev class end" })
vim.keymap.set("n", "]p", function() ts_move("next", parameter_types) end, { desc = "Next parameter" })
vim.keymap.set("n", "[p", function() ts_move("prev", parameter_types) end, { desc = "Prev parameter" })
vim.keymap.set("n", "]i", function() ts_move("next", conditional_types) end, { desc = "Next conditional" })
vim.keymap.set("n", "[i", function() ts_move("prev", conditional_types) end, { desc = "Prev conditional" })
vim.keymap.set("n", "]l", function() ts_move("next", loop_types) end, { desc = "Next loop" })
vim.keymap.set("n", "[l", function() ts_move("prev", loop_types) end, { desc = "Prev loop" })

-- ── Swap parameters ─────────────────────────────────────────────────────────
local function ts_swap(direction)
  local parser = ts.get_parser()
  if not parser then return end
  local tree = parser:trees()[1]
  if not tree then return end
  local root = tree:root()
  local cursor = api.nvim_win_get_cursor(0)
  local row, col = cursor[1] - 1, cursor[2]

  local node = root:named_descendant_for_range(row, col, row, col)
  local target = find_ancestor(node, parameter_types)
  if not target then return end

  for i = 0, target:named_child_count() - 1 do
    local child = target:named_child(i)
    if child then
      local sr, sc, er, ec = child:range()
      if sr <= row and row <= er then
        local idx = direction == "next" and i + 1 or i - 1
        local other = target:named_child(idx)
        if other then
          local text_a = api.nvim_buf_get_text(0, sr, sc, er, ec, {})
          local osr, osc, oer, oec = other:range()
          local text_b = api.nvim_buf_get_text(0, osr, osc, oer, oec, {})
          -- Swap: write longer text first to avoid position shifts
          if sr < osr or (sr == osr and sc < osc) then
            api.nvim_buf_set_text(0, osr, osc, oer, oec, text_a)
            api.nvim_buf_set_text(0, sr, sc, er, ec, text_b)
          else
            api.nvim_buf_set_text(0, sr, sc, er, ec, text_b)
            api.nvim_buf_set_text(0, osr, osc, oer, oec, text_a)
          end
        end
        return
      end
    end
  end
end

vim.keymap.set("n", "].", function() ts_swap("next") end, { desc = "Swap next parameter" })
vim.keymap.set("n", "[.", function() ts_swap("prev") end, { desc = "Swap prev parameter" })

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
