local wezterm = require 'wezterm'

local wsl_domains = wezterm.default_wsl_domains()

--wezterm.on("gui-startup", function(cmd)
--  local _, _, window = wezterm.mux.spawn_window(cmd or {})
--  window:gui_window():toggle_fullscreen()
--end)

for _, domain in ipairs(wsl_domains) do
  domain.default_cwd = "~"
end

return {
  adjust_window_size_when_changing_font_size = false,
  audible_bell = 'Disabled',
  background = {
    {
      source = { File = "c:/Users/Alex/Pictures/backgrounds/black.jpg" },
      opacity = 1.0
    },
    {
      source = { File = "c:/Users/Alex/Pictures/backgrounds/manga.jpg" },
--	  attachment = "Scroll",
--      horizontal_align = 'Center',
--      vertical_align = 'Middle',
      height = 'Cover',
      width = 'Cover',
--      repeat_x = 'NoRepeat',
--      repeat_y = 'NoRepeat',
      opacity = 0.2
    },
  },
--  color_scheme = 'Catppuccin Macchiato',
--  color_scheme = 'One Dark',
  color_scheme = 'Kanagawa (Gogh)',
  disable_default_key_bindings = true,
  exit_behavior = 'Close',
  font = wezterm.font 'JetBrains Mono',
  font_size = 14,
  force_reverse_video_cursor = true,
  hide_mouse_cursor_when_typing = true,
  hide_tab_bar_if_only_one_tab = true,
  keys = {
    { action = wezterm.action.ActivateCommandPalette, mods = 'CTRL|SHIFT', key =     'P' },
    { action = wezterm.action.CopyTo    'Clipboard' , mods = 'CTRL|SHIFT', key =     'C' },
    { action = wezterm.action.DecreaseFontSize      , mods = 'CTRL|SHIFT', key =     '-' },
    { action = wezterm.action.IncreaseFontSize      , mods = 'CTRL|SHIFT', key =     '=' },
    { action = wezterm.action.Nop                   , mods =        'ALT', key = 'Enter' },
    { action = wezterm.action.PasteFrom 'Clipboard' , mods = 'CTRL|SHIFT', key =     'V' },
    { action = wezterm.action.ResetFontSize         , mods = 'CTRL|SHIFT', key =     '0' },
    { action = wezterm.action.ToggleFullScreen      ,                      key =   'F11' },
  },
  show_update_window = true,
  use_dead_keys = false,
  window_close_confirmation = 'NeverPrompt',
  window_padding = {
    left = 0,
    right = 0,
    top = '0.6cell',
    bottom = 0,
  },
  wsl_domains = wsl_domains,
}