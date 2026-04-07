local icons = {
  cmp = require("icons")["cmp"],
  diagnostics = require("icons")["diagnostics"],
  kind = require("icons")["kind"],
  type = require("icons")["type"],
  ui = require("icons")["ui"],
}

require("lspsaga").setup({
  -- Breadcrumbs: https://nvimdev.github.io/lspsaga/breadcrumbs/
  symbol_in_winbar = {
    separator = " " .. icons.ui.Separator,
  },
  -- https://nvimdev.github.io/lspsaga/callhierarchy/
  callhierarchy = {
    layout = "float",
    keys = {
      edit = "e",
      vsplit = "s",
      split = "S",
      tabe = "t",
      quit = "q",
      shuttle = "[]",
      toggle_or_req = "u",
      close = "<Esc>",
    },
  },
  -- https://nvimdev.github.io/lspsaga/codeaction/
  code_action = {
    num_shortcut = true,
    only_in_cursor = false,
    show_server_name = true,
    extend_gitsigns = false,
    keys = {
      quit = "q",
      exec = "<CR>",
    },
  },
  -- https://nvimdev.github.io/lspsaga/diagnostic/
  diagnostic = {
    max_width = 0.5,
    max_height = 0.6,
    show_code_action = true,
    show_layout = "float",
    keys = {
      exec_action = "r",
      quit = "q",
      toggle_or_jump = "<CR>",
      quit_in_show = { "q", "<Esc>" },
    },
  },
  -- https://nvimdev.github.io/lspsaga/hover/
  hover = {
    max_width = 0.45,
    max_height = 0.7,
    open_link = "gl",
  },
  -- https://nvimdev.github.io/lspsaga/implement/
  implement = {
    virtual_text = false,
  },
  -- https://nvimdev.github.io/lspsaga/lightbulb/
  lightbulb = {
    enable = true,
    sign = true,
    virtual_text = true,
    sign_priority = 20,
  },
  -- https://nvimdev.github.io/lspsaga/rename/
  rename = {
    keys = {
      quit = "<Esc>",
      select = "x",
      exec = "<CR>",
    },
  },
  -- https://nvimdev.github.io/lspsaga/misc/#beacon
  beacon = {
    enable = true,
    frequency = 8,
  },
  -- https://nvimdev.github.io/lspsaga/outline
  outline = {
    detail = false,
    auto_close = true,
    close_after_jump = true,
  },
  -- https://nvimdev.github.io/lspsaga/misc/#generic-ui-options
  ui = {
    title = true,
    devicon = true,
    border = "single", -- Can be single, double, rounded, solid, shadow.
    actionfix = icons.ui.Spell,
    expand = icons.ui.ArrowClosed,
    collapse = icons.ui.ArrowOpen,
    code_action = icons.ui.CodeAction,
    imp_sign = icons.kind.Implementation,
    kind = {
      -- Kind
      Class = { icons.kind.Class, "LspKindClass" },
      Constant = { icons.kind.Constant, "LspKindConstant" },
      Constructor = { icons.kind.Constructor, "LspKindConstructor" },
      Enum = { icons.kind.Enum, "LspKindEnum" },
      EnumMember = { icons.kind.EnumMember, "LspKindEnumMember" },
      Event = { icons.kind.Event, "LspKindEvent" },
      Field = { icons.kind.Field, "LspKindField" },
      File = { icons.kind.File, "LspKindFile" },
      Function = { icons.kind.Function, "LspKindFunction" },
      Interface = { icons.kind.Interface, "LspKindInterface" },
      Key = { icons.kind.Keyword, "LspKindKey" },
      Method = { icons.kind.Method, "LspKindMethod" },
      Module = { icons.kind.Module, "LspKindModule" },
      Namespace = { icons.kind.Namespace, "LspKindNamespace" },
      Number = { icons.kind.Number, "LspKindNumber" },
      Operator = { icons.kind.Operator, "LspKindOperator" },
      Package = { icons.kind.Package, "LspKindPackage" },
      Property = { icons.kind.Property, "LspKindProperty" },
      Struct = { icons.kind.Struct, "LspKindStruct" },
      TypeParameter = { icons.kind.TypeParameter, "LspKindTypeParameter" },
      Variable = { icons.kind.Variable, "LspKindVariable" },
      -- Type
      Array = { icons.type.Array, "LspKindArray" },
      Boolean = { icons.type.Boolean, "LspKindBoolean" },
      Null = { icons.type.Null, "LspKindNull" },
      Object = { icons.type.Object, "LspKindObject" },
      String = { icons.type.String, "LspKindString" },
      -- ccls-specific icons.
      TypeAlias = { icons.kind.TypeAlias, "LspKindTypeAlias" },
      Parameter = { icons.kind.Parameter, "LspKindParameter" },
      StaticMethod = { icons.kind.StaticMethod, "LspKindStaticMethod" },
      -- Microsoft-specific icons.
      Text = { icons.kind.Text, "LspKindText" },
      Snippet = { icons.kind.Snippet, "LspKindSnippet" },
      Folder = { icons.kind.Folder, "LspKindFolder" },
      Unit = { icons.kind.Unit, "LspKindUnit" },
      Value = { icons.kind.Value, "LspKindValue" },
    },
  },
  -- https://nvimdev.github.io/lspsaga/misc/#scrolling-keymaps
  scroll_preview = {
    scroll_down = "<S-j>",
    scroll_up = "<S-k>",
  },
})
