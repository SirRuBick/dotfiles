# Neovim Configuration

Minimal, plugin-manager-free Neovim config using `vim.pack` (built-in), native treesitter, and Neovim 0.12 built-in features.

## Architecture

```
nvim/
├── init.lua                     # Bootstrap: requires all modules
├── lua/
│   ├── options.lua              # vim.opt settings, SSH clipboard
│   ├── theme.lua                # Colorscheme (catppuccin), transparency toggle
│   ├── keymaps.lua              # Global keymaps, flash, buffer management, incremental selection
│   ├── autocmds.lua             # CookLazy, LazyFile, yank highlight, auto-save
│   ├── statusline.lua           # Statusline config (mini.statusline)
│   ├── terminal.lua             # Floating terminal system
│   ├── plugins.lua              # vim.pack.add() declarations
│   ├── treesitter.lua           # Built-in treesitter (highlight, text objects, movement, swap, peek)
│   └── lsp/
│       ├── init.lua             # LSP setup, diagnostics, keymaps, efm-langserver, commands
│       └── servers.lua          # Server configurations (lua_ls, rust_analyzer, pyright, ...)
├── after/
│   └── plugin/
│       ├── blink.lua            # blink.cmp completion
│       ├── dap.lua              # DAP (debugging) config + keymaps
│       ├── devicons.lua         # File icons
│       ├── fzf.lua              # fzf-lua config, which-key
│       ├── gitsigns.lua         # Git signs, blame, hunk actions
│       ├── mini.lua             # mini.statusline + mini.starter + mini.tabline
│       ├── oil.lua              # Oil file explorer
│       └── render-markdown.lua  # Inline markdown rendering
├── parser/                      # Compiled treesitter parsers (.so / .dll)
└── scripts/
    └── install-parsers.sh       # Regenerate parsers from grammar source
```

## Plugins (vim.pack)

| Plugin | Purpose |
|---|---|
| oil.nvim | File explorer |
| nvim-treesitter-context | Sticky function/class header |
| nvim-lspconfig | LSP configurations |
| efmls-configs-nvim | Linting + formatting via efm-langserver |
| nvim-web-devicons | File icons |
| nvim-autopairs | Auto-close brackets |
| fzf-lua | Fuzzy finder |
| flash.nvim | Jump to position |
| nvim-surround | Surround motions |
| which-key.nvim | Keybinding hints |
| mini.nvim | Statusline + start screen + buffer tabline |
| mason.nvim | LSP/DAP/linter installer |
| gitsigns.nvim | Git gutter signs, blame, hunk actions |
| plenary.nvim | Lua utility library (dependency) |
| nvim-dap | Debug Adapter Protocol |
| nvim-dap-virtual-text | Inline debug variable values |
| nvim-dap-ui | Debug UI |
| nvim-nio | Async library (dap-ui dependency) |
| render-markdown.nvim | Inline markdown rendering |
| blink.cmp | Auto-completion engine |
| blink.lib | blink.cmp dependency |
| blink.compat | blink.cmp LuaSnip compatibility |
| LuaSnip | Snippet engine |
| friendly-snippets | Snippet collection |

## LSP + Linting/Formatting

| Server | Language |
|---|---|
| lua_ls | Lua |
| rust_analyzer | Rust |
| pyright | Python |
| bashls | Bash |
| ts_ls | TypeScript/JavaScript |
| gopls | Go |
| clangd | C/C++ |
| efm | Linting & formatting (all languages) |

Formatting on save via efm-langserver (autocmd `BufWritePre`). Linters run on open/change.
Requires Mason to install server binaries (`:Mason`).

---

## Keymaps

Leader: `Space`

### General

| Key | Mode | Action |
|---|---|---|
| `<C-s>` | i, n, v | Save file |
| `<C-a>` | i, n | Select all |
| `<leader>q` | n | Save all and quit |
| `<leader>ob` | n | Toggle transparency |
| `n` | n | Next search result (centered) |
| `N` | n | Previous search result (centered) |

### Line Movement

| Key | Mode | Action |
|---|---|---|
| `<A-j>` | n, v | Move line/selection down |
| `<A-k>` | n, v | Move line/selection up |

### Window Management

| Key | Mode | Action |
|---|---|---|
| `<C-Up>` | n | Increase window height |
| `<C-Down>` | n | Decrease window height |
| `<C-Left>` | n | Decrease window width |
| `<C-Right>` | n | Increase window width |
| `<leader>wH` | n | Move window to far left |
| `<leader>wJ` | n | Move window to bottom |
| `<leader>wK` | n | Move window to top |
| `<leader>wL` | n | Move window to far right |

### Tabs

| Key | Mode | Action |
|---|---|---|
| `<leader><tab><tab>` | n | New tab |
| `<leader><tab>d` | n | Close tab |
| `<leader><tab>o` | n | Close other tabs |
| `<leader><tab>l` | n | Next tab |
| `<leader><tab>h` | n | Previous tab |

### Buffer Management

| Key | Mode | Action |
|---|---|---|
| `]b` | n | Next buffer (built-in `:bnext`) |
| `[b` | n | Previous buffer (built-in `:bprev`) |
| `<leader>bb` | n | Switch to alternate buffer (`:b#`) |
| `<leader>bd` | n | Delete buffer (`:bdelete`) |
| `<leader>fb` | n | Fuzzy buffer picker (fzf-lua) |
| `<leader>bo` | n | Close other buffers |

Buffer bar shown by mini.tabline at top. Click to switch, middle-click to close.

### File Explorer (Oil)

| Key | Mode | Action |
|---|---|---|
| `<leader>e` | n | Toggle Oil file explorer |

### Fuzzy Finder (fzf-lua)

| Key | Mode | Action |
|---|---|---|
| `<leader>ff` | n | Find files |
| `<leader>fg` | n | Live grep |
| `<leader>fb` | n | Find buffers |
| `<leader>fo` | n | Recent files |
| `<leader>fs` | n | Grep word under cursor |
| `<leader>fk` | n | Find keymaps |
| `<leader>fh` | n | Find help tags |

### Flash (Jump)

| Key | Mode | Action |
|---|---|---|
| `s` | n, x, o | Flash jump |
| `S` | n, o, x | Flash treesitter |
| `r` | o | Flash remote |
| `R` | o, x | Flash treesitter search |
| `<C-s>` | c | Flash toggle search |

### Completion (blink.cmp)

| Key | Mode | Action |
|---|---|---|
| `<Tab>` | i | Next item / snippet forward |
| `<S-Tab>` | i | Previous item / snippet backward |
| `<CR>` | i | Accept completion |
| `<C-Space>` | i | Trigger completion |

### LSP

| Key | Mode | Action |
|---|---|---|
| `<leader>d` | n | Show diagnostic float |
| `<leader>lf` | n | Format buffer |
| `<leader>cR` | n | LSP rename |
| `<leader>cd` | n | Go to definition |
| `<leader>cr` | n | Go to references |
| `<leader>ci` | n | Go to implementation |
| `<leader>ct` | n | Go to type definition |
| `<leader>ca` | n | Code actions |
| `<leader>cs` | n | Document symbols |
| `<leader>cw` | n | Workspace symbols |
| `<leader>cW` | n | Workspace diagnostics |
| `<leader>lw` | n | Workspace symbols |

### Floating Terminal

| Key | Mode | Action |
|---|---|---|
| `<leader>tt` | n | Toggle floating terminal |
| `<leader>gg` | n | Toggle lazygit |
| `<C-\><C-\>` | t | Toggle floating terminal (from terminal mode) |

### Treesitter — Incremental Selection (Neovim 0.12+ built-in)

| Key | Mode | Action |
|---|---|---|
| `<CR>` | n, x | Expand selection to parent node |
| `<BS>` | x | Shrink selection to child node |

Supports count prefix (e.g., `3<CR>`). Uses LSP `selectionRange` as fallback when no treesitter parser is available.

### Treesitter — Text Objects

Visual mode (`v`) and operator-pending mode (`d`, `c`, `y`, etc.)

| Key | Action |
|---|---|
| `af` / `if` | Function outer / inner |
| `ac` / `ic` | Class outer / inner |
| `aa` / `ia` | Parameter outer / inner |
| `ai` / `ii` | Conditional outer / inner |
| `al` / `il` | Loop outer / inner |
| `a=` / `i=` | Assignment outer / inner |
| `as` / `is` | Scope outer / inner |

### Treesitter — Movement

| Key | Mode | Action |
|---|---|---|
| `]m` / `[m` | n | Next / prev function start |
| `]M` / `[M` | n | Next / prev function end |
| `]]` / `[[` | n | Next / prev class start |
| `][` / `[]` | n | Next / prev class end |
| `]p` / `[p` | n | Next / prev parameter |
| `]i` / `[i` | n | Next / prev conditional |
| `]l` / `[l` | n | Next / prev loop |

### Treesitter — Swap

| Key | Mode | Action |
|---|---|---|
| `].` | n | Swap parameter with next |
| `[.` | n | Swap parameter with prev |

### Treesitter — Peek Definition

| Key | Mode | Action |
|---|---|---|
| `<leader>lp` | n | Peek definition in floating window |

### Git (Gitsigns)

| Key | Mode | Action |
|---|---|---|
| `]h` / `[h` | n | Next / prev git hunk |
| `<leader>gs` | n, v | Stage hunk |
| `<leader>gr` | n, v | Reset hunk |
| `<leader>gS` | n | Stage buffer |
| `<leader>gu` | n | Undo stage hunk |
| `<leader>gR` | n | Reset buffer |
| `<leader>gp` | n | Preview hunk |
| `<leader>gb` | n | Blame line |
| `<leader>gd` | n | Diff this |
| `<leader>gD` | n | Diff this ~ |
| `<leader>gtb` | n | Toggle line blame |
| `<leader>gtd` | n | Toggle deleted |

### DAP (Debugging)

| Key | Mode | Action |
|---|---|---|
| `<leader>dc` | n | Continue |
| `<leader>do` | n | Step over |
| `<leader>di` | n | Step into |
| `<leader>dO` | n | Step out |
| `<leader>db` | n | Toggle breakpoint |
| `<leader>dB` | n | Conditional breakpoint |
| `<leader>dr` | n | Open REPL |
| `<leader>dl` | n | Run last |
| `<leader>dt` | n | Terminate |
| `<leader>du` | n | Toggle DAP UI |

---

## User Commands

| Command | Action |
|---|---|
| `:LspInfo` | Check LSP health |
| `:LspLog` | Open LSP log |
| `:PackUpdate` | Update all plugins |
| `:PackUpdate <name>` | Update specific plugin |
| `:PackDel <name>` | Delete plugin |
| `:PackGet` | Show all installed plugins |

---

## Treesitter Parsers

22 custom parsers in `nvim/parser/` + 7 built-in Neovim parsers.

**Custom:** bash, c_sharp, comment, cpp, css, csv, diff, gitignore, html, http, json, kdl, luadoc, luap, python, regex, rust, sql, toml, tsx, xml, yaml

**Built-in:** c, lua, markdown, markdown_inline, query, vim, vimdoc

### Regenerate parsers

Requires: gcc, tree-sitter CLI (installed via bootstrap.sh)

```bash
./nvim/scripts/install-parsers.sh --all
./nvim/scripts/install-parsers.sh python c cpp json yaml kdl
```

---

## Autocmds

| Event | Action |
|---|---|
| ColorScheme | Apply transparency |
| VimEnter | Fire `CookLazy` event |
| BufReadPost/BufNewFile (once) | Fire `LazyFile` event |
| LspAttach | Register LSP keymaps |
| BufWritePre | Format on save via efm |
| TextYankPost | Highlight yanked text |
| FileType | Disable auto-wrap comments |
| BufLeave/FocusLost | Auto-save modified buffers |

---

*Last updated: 2026-05-25*
