local icons = {
  diagnostics = require("icons")["diagnostics"],
  documents = require("icons")["documents"],
  git = require("icons")["git"],
  ui = require("icons")["ui"],
}
local float_settings = require("settings").float

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set("n", "s", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set("n", "S", api.node.open.horizontal, opts("Open: Horizontal Split"))
  vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

require("nvim-tree").setup({
  on_attach = my_on_attach,
  auto_reload_on_write = true,
  create_in_closed_folder = false,
  disable_netrw = false,
  hijack_cursor = true,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = true,
  open_on_tab = false,
  respect_buf_cwd = false,
  sort_by = "name",
  sync_root_with_cwd = true,
  view = {
    adaptive_size = false,
    centralize_selection = false,
    width = 30,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    float = {
      enable = float_settings.enable,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * float_settings.width_ratio
        local window_h = screen_h * float_settings.height_ratio
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)
        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.opt.lines:get() - window_h) / 2)
            - vim.opt.cmdheight:get()
        return {
          border = "rounded",
          relative = "editor",
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
      end,
    },
  },
  renderer = {
    add_trailing = false,
    group_empty = true,
    highlight_git = true,
    full_name = false,
    highlight_opened_files = "none",
    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "CMakeLists.txt" },
    symlink_destination = true,
    indent_markers = {
      enable = true,
      icons = {
        corner = "└ ",
        edge = "│ ",
        item = "│ ",
        none = "  ",
      },
    },
    root_folder_label = ":.:s?.*?/..?",
    icons = {
      webdev_colors = true,
      git_placement = "after",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      padding = " ",
      symlink_arrow = " 󰁔 ",
      glyphs = {
        default = icons.documents.Default,   --
        symlink = icons.documents.Symlink,   --
        bookmark = icons.ui.Bookmark,
        git = {
          unstaged = icons.git.Mod_alt,
          staged = icons.git.Add,            --󰄬
          unmerged = icons.git.Unmerged,
          renamed = icons.git.Rename,        --󰁔
          untracked = icons.git.Untracked,   -- "󰞋"
          deleted = icons.git.Remove,        --
          ignored = icons.git.Ignore,        --◌
        },
        folder = {
          arrow_open = icons.ui.ArrowOpen,
          arrow_closed = icons.ui.ArrowClosed,
          -- arrow_open = "",
          -- arrow_closed = "",
          default = icons.ui.Folder,
          open = icons.ui.FolderOpen,
          empty = icons.ui.EmptyFolder,
          empty_open = icons.ui.EmptyFolderOpen,
          symlink = icons.ui.SymlinkFolder,
          symlink_open = icons.ui.FolderOpen,
        },
      },
    },
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = true,
    update_root = true,
    ignore_list = {},
  },
  filters = {
    dotfiles = false,
    custom = { ".DS_Store" },
    exclude = {},
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
    },
    open_file = {
      quit_on_open = true,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "terminal", "help" },
        },
      },
    },
    remove_file = {
      close_window = true,
    },
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    debounce_delay = 50,
    icons = {
      hint = icons.diagnostics.Hint_alt,
      info = icons.diagnostics.Information_alt,
      warning = icons.diagnostics.Warning_alt,
      error = icons.diagnostics.Error_alt,
    },
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
  },
  git = {
    enable = true,
    ignore = false,
    show_on_dirs = true,
    timeout = 400,
  },
  trash = {
    cmd = "gio trash",
    require_confirm = true,
  },
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      dev = false,
      diagnostics = false,
      git = false,
      profile = false,
      watcher = false,
    },
  },
})
