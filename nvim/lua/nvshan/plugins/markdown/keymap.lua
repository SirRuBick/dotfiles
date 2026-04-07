local is_available = require("utils").is_available
local keymap_utils = require("nvshan.keymap.utils")
local mappings = keymap_utils.init_mapping()
local map = keymap_utils.map
local wk_icons = require("icons").whichkey
local obsidian_settings = require("settings").obsidian
local utils = require("utils")

if obsidian_settings.enable and not is_available("obsidian.nvim") then
  vim.notify("Failed to load obsidian", vim.log.levels.ERROR)
  return {}
end

mappings.n["<leader>n"] = map():desc(wk_icons.n)
mappings.v["<leader>n"] = map():desc(wk_icons.n)

mappings.n["<leader>n."] = map("<CMD>ObsidianToday<CR>"):desc("Today")
mappings.n["<leader>n["] = map("<CMD>ObsidianYesterday<CR>"):desc("Previous Working Day")
mappings.n["<leader>n]"] = map("<CMD>ObsidianTomorrow<CR>"):desc("Next Working Day")
mappings.n["<leader>no"] = map(function()
  vim.ui.input({ prompt = "Offset: " }, function(offset)
    if offset == nil or offset == "" then
      return
    end
    vim.cmd("ObsdianToday " .. offset)
  end)
end):desc("Daily with offset")
mappings.n["<leader>ne"] = map("<CMD>e" .. utils.join_path(obsidian_settings.vault_path, obsidian_settings.entry_file) .. "<CR>"):desc("Open Entry Note")
mappings.n["<leader>ng"] = map("<CMD>ObsidianOpen<CR>"):desc("Go to Obsidian App")
mappings.n["<leader>nn"] = map("<CMD>ObsidianNew<CR>"):desc("New Note")
mappings.n["<leader>nd"] = map("<CMD>ObsidianDailies<CR>"):desc("Find Daily Notes")
mappings.n["<leader>nc"] = map("<CMD>ObsidianToggleCheckbox<CR>"):desc("Toggle checkbox")
mappings.n["<leader>nf"] = map("<CMD>ObsidianSearch<CR>"):desc("Find note")
mappings.n["<leader>nt"] = map("<CMD>ObsidianTags<CR>"):desc("Find Tag")
mappings.n["<leader>ni"] = map("<CMD>ObsidianPasteImg<CR>"):desc("Paste Image")
mappings.n["<leader>nl"] = map("<CMD>ObsidianLinks<CR>"):desc("Search Links for current note")
mappings.n["<leader>np"] = map("<CMD>ObsidianTemplate<CR>"):desc("Insert Template")
mappings.n["<leader>nr"] = map("<CMD>ObsidianRename<CR>"):desc("Paste Image")
mappings.n["<leader>ns"] = map("<CMD>ObsidianQuickSwitch<CR>"):desc("Quick Switch")
mappings.n["<leader>nw"] = map("<CMD>ObsidianWorkspace<CR>"):desc("Switch Workspace")
mappings.n["gd"] = map(function()
    if require("obsidian").util.cursor_on_markdown_link() then
      vim.cmd("ObsidianFollowLink")
    else
      vim.cmd("gd")
    end
  end)
  -- :expr()
  :desc("Follow Link")
mappings.n["gp"] = map("<CMD>ObsidianBacklinks<CR>"):desc("Back Links")

mappings.v["<leader>ne"] = map("<CMD>ObsidianExtractNote<CR>"):desc("Extract selected to New Note and link")
mappings.v["<leader>nl"] = map("<CMD>ObsidianLink<CR>"):desc("Link selected to existing Note")
mappings.v["<leader>nn"] = map("<CMD>ObsidianLinkNew<CR>"):desc("Link selected to new Note")

return mappings
