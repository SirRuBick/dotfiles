# Vim Shortcuts — Cross-Platform Status

`<leader>` = `<Space>` on all platforms.

---

## Navigation — `]` / `[` bracket jumps

| Shortcut | Description | nvim | vscode | ideavim | obsidian |
|---|---|---|---|---|---|
| `[d` / `]d` | Prev/next diagnostic | ✅ | ✅ | ✅ | ❌ |
| `[h` / `]h` | Prev/next git change | ✅ | ✅ | ✅ | ✅ |
| `[r` / `]r` | Prev/next reference | ✅ | ✅ (GitLens) | ✅ | ❌ |
| `[b` / `]b` | Prev/next buffer | ✅ | ✅ | ✅ | ✅ tabs |
| `[q` / `]q` | Prev/next quickfix | ✅ | ✅ | ✅ | ❌ |
| `[l` / `]l` | Prev/next location | ✅ | ✅ | ✅ | ❌ |
| `[t` / `]t` | Prev/next tab | ✅ | ✅ | ✅ | ✅ |
| `[f` / `]f` | Prev/next method | ❌ | ❌ | ✅ | ❌ |
| `[p` / `]p` | Prev/next parameter | ❌ | ❌ | ✅ | ❌ |
| `[e` / `]e` | Prev/next error | ❌ | ❌ | ✅ | ❌ |

---

## Go-to code — `g` prefix

| Shortcut | Description | nvim | vscode | ideavim | obsidian |
|---|---|---|---|---|---|
| `gd` | Go to definition | ✅ | ✅ | ✅ | ⚠️ follow link |
| `gD` | Go to declaration | ✅ | ✅ | ✅ | ❌ |
| `gI` | Go to implementation | ✅ | ✅ | ✅ | ❌ |
| `gT` | Go to type definition | ✅ | ✅ | ✅ | ❌ |
| `gh` | Show hover info | ❌ | ✅ | ✅ | ❌ |
| `gu` | Find references | ❌ | ✅ | ✅ | ❌ |
| `gU` | Show usages | ❌ | ❌ | ✅ | ❌ |
| `gy` | Go to type declaration | ❌ | ✅ | ✅ | ❌ |
| `gp` | Go to super method | ❌ | ❌ | ✅ | ❌ |
| `gs` | Signature help | ✅ | ✅ | ✅ | ❌ |
| `gt` | Go to test | ❌ | ❌ | ✅ | ❌ |
| `gw` | Go to class | ❌ | ❌ | ✅ | ❌ |

---

## Jump list

| Shortcut | Description | nvim | vscode | ideavim | obsidian |
|---|---|---|---|---|---|
| `<C-o>` | Jump back | ✅ | ✅ | ✅ | ✅ |
| `<C-i>` | Jump forward | ✅ | ✅ | ✅ | ✅ |

---

## Line navigation

| Shortcut | Description | nvim | vscode | ideavim | obsidian |
|---|---|---|---|---|---|
| `H` | Start of line | ✅ | ✅ | ✅ | ✅ |
| `L` | End of line | ✅ | ✅ | ✅ | ✅ |

---

## Indent / Unindent

| Shortcut | Description | nvim | vscode | ideavim | obsidian |
|---|---|---|---|---|---|
| `<Tab>` | Indent line / selection | ✅ | ✅ | ✅ | ✅ |
| `<S-Tab>` | Unindent line / selection | ✅ | ✅ | ✅ | ✅ |

---

## File finder

| Shortcut | Description | nvim | vscode | ideavim | obsidian |
|---|---|---|---|---|---|
| `<leader>ff` | Find files | ✅ | ✅ | ✅ | ✅ Quick Switcher |
| `<leader>fw` | Search in files | ✅ | ✅ | ✅ | ✅ Global Search |
| `<leader>fa` | Search everywhere | ✅ | ✅ | ✅ | ✅ Global Search |
| `<leader>fr` | Recent files | ✅ | ✅ | ✅ | ❌ |
| `<leader>fb` | Buffers | ✅ | ✅ | ✅ | ❌ |
| `<leader>ft` | Search / TODOs | ✅ | ✅ | ✅ | ❌ |
| `<leader>fs` | Grep word under cursor | ✅ | ✅ | ✅ | ❌ |

---

## Buffer management

| Shortcut | Description | nvim | vscode | ideavim | obsidian |
|---|---|---|---|---|---|
| `<leader>bd` | Close buffer | ✅ | ✅ | ✅ | ✅ close tab |
| `<leader>bo` | Close other buffers | ✅ | ✅ | ✅ | ✅ |
| `<leader>ba` | New file | ✅ | ✅ | ✅ | ❌ |
| `<leader>bb` | Switch buffer | ✅ | ✅ | ✅ | ✅ |

---

## LSP / Code

| Shortcut | Description | nvim | vscode | ideavim | obsidian |
|---|---|---|---|---|---|
| `<leader>la` | Code action | ✅ | ✅ | ✅ | ❌ |
| `<leader>lr` | References | ✅ | ✅ | ✅ | ❌ |
| `<leader>lf` | Format | ✅ | ✅ | ✅ | ❌ |
| `<leader>ld` | Definition | ✅ | ✅ | ✅ | ❌ |
| `<leader>le` | Next error | ✅ | ✅ | ✅ | ❌ |
| `<leader>lo` | Outline | ✅ | ✅ | ✅ | ✅ |
| `<leader>ls` | Document symbols | ✅ | ✅ | ✅ | ❌ |
| `<leader>li` | Implementation | ✅ | ✅ | ✅ | ❌ |
| `<leader>lt` | Type definition | ✅ | ✅ | ✅ | ❌ |
| `<leader>lR` | Rename | ✅ | ✅ | ✅ | ❌ |
| `<leader>lh` | Signature help | ✅ | ❌ | ✅ | ❌ |
| `<leader>lx` | Codelens run | ✅ | ❌ | ✅ | ❌ |

---

## LSP gr* keymaps (Neovim 0.11+ built-in)

| Shortcut | Description | nvim | ideavim |
|---|---|---|---|
| `gra` | Code action | ✅ | ✅ |
| `gri` | Go to implementation | ✅ | ✅ |
| `grn` | Rename | ✅ | ✅ |
| `grr` | Go to references | ✅ | ✅ |
| `grt` | Go to type definition | ✅ | ✅ |
| `grh` | Signature help | ✅ | ✅ |
| `grx` | Codelens run | ✅ | ❌ |
| `gO` | Document symbols | ✅ | ✅ |
| `gx` | Open document link | ✅ | ✅ |

---

## Git

| Shortcut | Description | nvim | vscode | ideavim | obsidian |
|---|---|---|---|---|---|
| `<leader>gg` | Lazygit / Git log | ✅ | ❌ (ext) | ✅ Vcs.Log | ✅ Git view |
| `<leader>gc` | Commit | ✅ | ✅ | ✅ | ✅ Git commit |
| `<leader>gs` | Source control | ✅ | ✅ | ✅ | ✅ Git status |
| `<leader>gd` | File history | ✅ | ✅ | ✅ Annotate | ❌ |
| `<leader>gb` | Blame | ✅ | ✅ (GitLens) | ✅ Annotate | ❌ |
| `<leader>gp` | Push | ✅ | ✅ | ✅ | ✅ |
| `<leader>gpl` | Pull | ✅ | ✅ | ✅ | ✅ |

---

## Debugger

| Shortcut | Description | nvim | vscode | ideavim | obsidian |
|---|---|---|---|---|---|
| `<leader>db` | Toggle breakpoint | ✅ | ✅ | ✅ | ❌ |
| `<leader>dc` | Continue / Start | ✅ | ✅ | ✅ | ❌ |
| `<leader>dd` | Disconnect | ✅ | ✅ | ✅ | ❌ |
| `<leader>dt` | Stop | ✅ | ✅ | ✅ | ❌ |
| `<leader>de` | Evaluate | ✅ | ✅ | ✅ | ❌ |
| `<leader>di` | Step into | ✅ | ✅ | ✅ | ❌ |
| `<leader>do` | Step over | ✅ | ✅ | ✅ | ❌ |
| `<leader>dO` | Step out | ✅ | ✅ | ✅ | ❌ |
| `<leader>dl` | Run to cursor | ❌ | ❌ | ✅ | ❌ |

---

## Display / UI

| Shortcut | Description | nvim | vscode | ideavim | obsidian |
|---|---|---|---|---|---|
| `<leader>vz` | Zen mode | ❌ | ✅ | ✅ | ❌ |
| `<leader>vd` | Distraction free | ❌ | ✅ | ✅ | ❌ |
| `<leader>vf` | Full screen | ❌ | ✅ | ✅ | ❌ |

---

## Selection expand / shrink

| Shortcut | Description | nvim | vscode | ideavim | obsidian |
|---|---|---|---|---|---|
| `<A-o>` | Expand selection | ✅ | ❌ | ✅ | ❌ |
| `<A-i>` | Shrink selection | ✅ | ❌ | ✅ | ❌ |

---

## File Explorer

| Shortcut | Description | nvim | vscode | ideavim | obsidian |
|---|---|---|---|---|---|
| `<leader>e` | Toggle sidebar / File tree | ✅ (NvimTree) | ✅ (toggle) | ✅ (Project Tool) | ✅ |
| `a` | New file | ❌ | ✅ | ❌ | ✅ (`<leader>en`) |
| `A` (Shift+a) | New folder | ❌ | ✅ | ❌ | ✅ (`<leader>eN`) |
| `r` | Rename | ❌ | ✅ | ❌ | ✅ (`<leader>er`) |
| `d` | Delete | ❌ | ✅ | ❌ | ✅ (`<leader>ed`) |
| `y` | Copy | ❌ | ✅ | ❌ | ❌ |
| `x` | Cut | ❌ | ✅ | ❌ | ❌ |
| `p` | Paste | ❌ | ✅ | ❌ | ❌ |
| `o` / `<Enter>` | Open file / Toggle folder | ✅ (NvimTree) | ✅ (smart) | ✅ (Project Tool) | ❌ |
| `s` | Open in split | ❌ | ✅ | ❌ | ❌ |
| `gg` | Go to top | ❌ | ✅ | ❌ | ❌ |
| `G` | Go to bottom | ❌ | ✅ | ❌ | ❌ |
| `/` | Search / filter | ❌ | ✅ | ❌ | ❌ |
| `R` | Refresh | ❌ | ✅ | ❌ | ❌ |
| `j/k/h/l` | Navigate tree | ✅ (NvimTree) | ✅ (native) | ✅ | ❌ |

Note: nvim uses NvimTree plugin (`<A-1>` opens). VSCode/ideavim native explorer. Obsidian limited to `<leader>e` prefix commands only.

---

## Split navigation & management

| Shortcut | Description | nvim | vscode | ideavim | obsidian |
|---|---|---|---|---|---|
| `<C-h/j/k/l>` | Navigate splits | ✅ | ❌ | ✅ | ✅ |
| `<leader>wh` | Vertical split left | ✅ | ❌ | ✅ | ✅ |
| `<leader>wj` | Horizontal split below | ✅ | ❌ | ✅ | ✅ |
| `<leader>wk` | Horizontal split above | ✅ | ❌ | ✅ | ✅ |
| `<leader>wl` | Vertical split right | ✅ | ❌ | ✅ | ✅ |
| `<leader>wq` | Close split | ✅ | ❌ | ✅ | ✅ |
| `<leader>wo` | Maximize (only) | ✅ | ❌ | ✅ | ✅ |
| `<leader>we` | Equalize splits | ✅ | ❌ | ✅ | ✅ |

---

## JetBrains-Specific (PyCharm, Rider, DataGrip)

| Shortcut | Description | PyCharm | Rider | DataGrip |
|---|---|---|---|---|
| `<leader>rr` | Run | ✅ | ✅ | ✅ |
| `<leader>rd` | Debug | ✅ | ✅ | ✅ |
| `<leader>rt` | Run class / test | ✅ | ✅ | ❌ |
| `<leader>rs` | Stop | ✅ | ✅ | ✅ |
| `<leader>rc` | Compile | ✅ | ✅ | ❌ |
| `<leader>rn` | Refactoring menu | ✅ | ✅ | ✅ |
| `<leader>rv` | Extract variable | ✅ | ✅ | ❌ |
| `<leader>rm` | Extract method | ✅ | ✅ | ❌ |
| `<leader>ri` | Inline | ✅ | ✅ | ❌ |
| `<leader>rk` | Change signature | ✅ | ✅ | ❌ |
| `<leader>th` | Type hierarchy | ✅ | ✅ | ❌ |
| `<leader>gt` | Go to related | ❌ | ✅ | ❌ |
| `<leader>xr` | Execute query | ❌ | ❌ | ✅ |
| `<leader>xc` | Open console | ❌ | ❌ | ✅ |
| `<leader>ma` | Toggle bookmark | ✅ | ✅ | ✅ |
| `<leader>1-5` | Tool windows | ✅ | ✅ | ✅ |

---

## Save / Quit

| Shortcut | Description | nvim | vscode | ideavim | obsidian |
|---|---|---|---|---|---|
| `<C-s>` | Save | ✅ | ✅ | ✅ | ✅ |
| `<C-a>` | Select all | ✅ | ✅ | ✅ | ✅ |
| `<leader>q` | Save & quit / Close tab | ✅ | ✅ | ✅ | ✅ |
| `<leader>w` | Save | ✅ | ✅ | ✅ | ✅ |
| `<leader>or` | Reload config | ✅ | ❌ | ✅ | ❌ |
| `P` (visual) | Swap selection with clipboard | ✅ | ❌ | ✅ | ✅ |

---

## Flash / EasyMotion — Search & Jump

| Shortcut | Description | nvim | vscode | ideavim | obsidian |
|---|---|---|---|---|---|
| `s` | Jump to 2-char match | ✅ (Flash) | ❌ | ✅ (EasyMotion) | ❌ |
| `S` | Line-level jump | ✅ (Flash treesitter) | ❌ | ✅ (EasyMotion) | ❌ |
| `gw` | Word-level jump | ❌ | ❌ | ✅ (EasyMotion) | ❌ |
| `<leader>s` | Jump across windows | ❌ | ❌ | ✅ (EasyMotion overwin) | ❌ |
