local obsidian = require("obsidian")
local obsidian_settings = require("settings").obsidian
local join_path = require("utils").join_path

local workspaces = {}
for _, wp in ipairs(obsidian_settings.workspaces) do
  table.insert(workspaces, { name = wp, path = join_path(obsidian_settings.vault_path, wp) })
end

obsidian.setup({
  dir = obsidian_settings.vault_path,
  -- workspaces = workspaces,

  -- Optional, if you keep notes in a specific subdirectory of your vault.
  notes_subdir = "0.Inbox/1.Notes",

  daily_notes = {
    -- Optional, if you keep daily notes in a separate directory.
    folder = "0.Inbox/1.Daily",
    -- Optional, if you want to change the date format for the ID of daily notes.
    date_format = "%Y-%m-%d",
    -- Optional, if you want to change the date format of the default alias of daily notes.
    alias_format = "%B %-d, %Y",
    -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
    template = nil,
  },

  -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
  completion = {
    -- Set to false to disable completion.
    nvim_cmp = true,
    -- Trigger completion at 2 chars.
    min_chars = 2,
  },

  -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
  -- way then set 'mappings = {}'.
  mappings = {
    -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
    -- ["gf"] = {
    --   action = function()
    --     return require("obsidian").util.gf_passthrough()
    --   end,
    --   opts = { noremap = false, expr = true, buffer = true },
    -- },
  },

  -- Where to put new notes. Valid options are
  --  * "current_dir" - put new notes in same directory as the current buffer.
  --  * "notes_subdir" - put new notes in the default notes subdirectory.
  new_notes_location = "notes_subdir",

  -- Templates
  templates = {
    subdir = "91.Templates",
    date_format = "%Y-%m-%d-%a",
    time_format = "%H:%M",
    -- A map for custom variables, the key should be the variable and the value a function
    substitutions = {},
  },

  -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
  open_app_foreground = true,

  ---@diagnostic disable: missing-fields
  picker = {
    -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
    name = "telescope.nvim",
    -- Optional, configure key mappings for the picker. These are the defaults.
    -- Not all pickers support all mappings.
    mappings = {
      -- Create a new note from your query.
      -- new = "<C-x>",
      -- Insert a link to the selected note.
      -- insert_link = "<C-l>",
    },
  },

  -- Specify how to handle attachments.
  attachments = {
    -- The default folder to place images in via `:ObsidianPasteImg`.
    -- If this is a relative path it will be interpreted as relative to the vault root.
    -- You can always override this per image by passing a full path to the command instead of just a filename.
    img_folder = "Extras/Images",
  },
})
