local bufferline = require("bufferline")

bufferline.setup({
  options = {
    mode = "buffers", -- set to "tabs" to only show tabpages instead
    style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
    themable = false, -- allows highlight groups to be overridden i.e. sets highlights as default
    numbers = "ordinal", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string
    indicator = {
      icon = "▎", -- this should be omitted if indicator style is not 'icon'
      style = "none", -- | 'underline' | 'none',
    },
    buffer_close_icon = "󰅖",
    modified_icon = "●",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    color_icons = true,
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_tab_indicators = true,
    separator_style = "slope",
    max_name_length = 10,
    max_prefix_length = 6, -- prefix used when a buffer is de-duplicated
    truncate_names = true, -- whether or not tab names should be truncated
    diagnostics = false, --"nvim_lsp",
    diagnostics_update_in_insert = false,
    -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        separator = true, -- use a "true" to enable the default, or set your own character
      },
      {
        filetype = "OutLine",
        text = "Symbols",
        highlight = "Directory",
        separator = true, -- use a "true" to enable the default, or set your own character
      },
    },
    -- groups = {
    --   options = {
    --     toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
    --   },
    --   items = {
    --     {
    --       name = "Tests",
    --       icon = "", -- Optional
    --       auto_close = true,
    --       matcher = function(buf) -- Mandatory
    --         return buf.name:match("test%_") or buf.name:match("%_spec")
    --       end,
    --     },
    --   },
    -- },
    custom_areas = {
      right = function()
        local result = {}

        local count = #vim.api.nvim_list_bufs()
        table.insert(result, { text = "  " .. count, fg = "#8700af" })

        return result
      end,
    },
  },
})
