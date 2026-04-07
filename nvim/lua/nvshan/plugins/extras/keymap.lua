local is_available = require("utils").is_available
local wk_icons = require("icons").whichkey
local keymap_utils = require("nvshan.keymap.utils")
local mappings = keymap_utils.init_mapping()
local map = keymap_utils.map

if is_available("ChatGPT.nvim") then
  mappings.n["<leader>m"] = map():desc(wk_icons.m)
  mappings.n["<leader>mc"] = map("<CMD>ChatGPT<CR>"):silent():noremap():desc("ChatGPT")
  mappings.n["<leader>mp"] = map("<CMD>ChatGPTActAs<CR>"):silent():noremap():desc("Awesome ChatGPT Prompts")
  mappings.n["<leader>me"] = map("<CMD>ChatGPTEditWithInstruction<CR>"):silent():noremap():desc("Edit with instruction")
  mappings.v["<leader>me"] = map("<CMD>ChatGPTEditWithInstruction<CR>"):silent():noremap():desc("Edit with instruction")
  mappings.n["<leader>mg"] = map("<CMD>ChatGPTRun grammar_correction<CR>"):silent():noremap():desc("Grammar Correction")
  mappings.v["<leader>mg"] = map("<CMD>ChatGPTRun grammar_correction<CR>"):silent():noremap():desc("Grammar Correction")
  mappings.n["<leader>mt"] = map("<CMD>ChatGPTRun translate<CR>"):silent():noremap():desc("Translate")
  mappings.v["<leader>mt"] = map("<CMD>ChatGPTRun translate<CR>"):silent():noremap():desc("Translate")
  mappings.n["<leader>mk"] = map("<CMD>ChatGPTRun keywords<CR>"):silent():noremap():desc("Keywords")
  mappings.v["<leader>mk"] = map("<CMD>ChatGPTRun keywords<CR>"):silent():noremap():desc("Keywords")
  mappings.n["<leader>md"] = map("<CMD>ChatGPTRun docstring<CR>"):silent():noremap():desc("Docstring")
  mappings.v["<leader>md"] = map("<CMD>ChatGPTRun docstring<CR>"):silent():noremap():desc("Docstring")
  mappings.n["<leader>ma"] = map("<CMD>ChatGPTRun add_tests<CR>"):silent():noremap():desc("Add Tests")
  mappings.v["<leader>ma"] = map("<CMD>ChatGPTRun add_tests<CR>"):silent():noremap():desc("Add Tests")
  mappings.n["<leader>mo"] = map("<CMD>ChatGPTRun optimize_code<CR>"):silent():noremap():desc("Optimize Code")
  mappings.v["<leader>mo"] = map("<CMD>ChatGPTRun optimize_code<CR>"):silent():noremap():desc("Optimize Code")
  mappings.n["<leader>ms"] = map("<CMD>ChatGPTRun summarize<CR>"):silent():noremap():desc("Summarize")
  mappings.v["<leader>ms"] = map("<CMD>ChatGPTRun summarize<CR>"):silent():noremap():desc("Summarize")
  mappings.n["<leader>mf"] = map("<CMD>ChatGPTRun fix_bugs<CR>"):silent():noremap():desc("Fix Bugs")
  mappings.v["<leader>mf"] = map("<CMD>ChatGPTRun fix_bugs<CR>"):silent():noremap():desc("Fix Bugs")
  mappings.n["<leader>mx"] = map("<CMD>ChatGPTRun explain_code<CR>"):silent():noremap():desc("Explain Code")
  mappings.v["<leader>mx"] = map("<CMD>ChatGPTRun explain_code<CR>"):silent():noremap():desc("Explain Code")
  mappings.n["<leader>ml"] = map("<CMD>ChatGPTRun code_readability_analysis<CR>"):silent():noremap():desc("Code Readability Analysis")
  mappings.v["<leader>ml"] = map("<CMD>ChatGPTRun code_readability_analysis<CR>"):silent():noremap():desc("Code Readability Analysis")
end

return mappings
