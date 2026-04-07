local is_available = require("utils").is_available
local keymap_utils = require("nvshan.keymap.utils")
local mappings = keymap_utils.init_mapping()
local map = keymap_utils.map

if is_available("todo-comments.nvim") then
  mappings.n["<leader>fD"] = map("<CMD>TodoTelescope<CR>"):desc("Find TODOs")
  mappings.n["<leader>xD"] = map("<CMD>TodoTrouble<CR>"):desc("Trouble TODOs")
  -- TODO: What about TodoQuickFix and TodoLocList?
end

if is_available("trouble.nvim") then
  mappings.n["<leader>xx"] = map("<CMD>TroubleToggle<CR>"):desc("Trouble Toggle")
  mappings.n["<leader>xw"] = map("<CMD>TroubleToggle workspace_diagnostics<CR>"):desc("Trouble Workspace Diagnostics")
  mappings.n["<leader>xd"] = map("<CMD>TroubleToggle document_diagnostics<CR>"):desc("Trouble Document Diagnostics")
  mappings.n["<leader>xl"] = map("<CMD>TroubleToggle loclist<CR>"):desc("Trouble Location List")
  mappings.n["<leader>xq"] = map("<CMD>TroubleToggle quickfix<CR>"):desc("Trouble Quickfix")
  mappings.n["<leader>xr"] = map("<CMD>TroubleToggle lsp_references<CR>"):desc("Trouble LSP References")
  mappings.n["<leader>xi"] = map("<CMD>TroubleToggle lsp_implementations<CR>"):desc("Trouble LSP Implementations")
  mappings.n["<leader>xf"] = map("<CMD>TroubleToggle lsp_definitions<CR>"):desc("Trouble LSP Definitions")
  mappings.n["<leader>xt"] = map("<CMD>TroubleToggle lsp_type_definitions<CR>"):desc("Trouble LSP Type Definitions")
end

if is_available("vim-illuminate") then
  mappings.n["<leader>ui"] = map(function()
    require("illuminate").toggle_buf()
  end):desc("Illuminate Toggle in local buffer")
  mappings.n["<leader>uI"] = map(function()
    require("illuminate").toggle()
  end):desc("Illuminate Toggle globally")
  mappings.n["[r"] = map(function()
    require("illuminate").goto_prev_reference()
  end):desc("Jump to previous reference")
  mappings.n["]r"] = map(function()
    require("illuminate").goto_next_reference()
  end):desc("Jump to next reference")
end

return mappings
