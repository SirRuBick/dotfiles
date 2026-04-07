# keymap
Some of the shortcuts I use frequently are listed here. <br>
In the following shortcuts, `<leader>` represents `space`.<br>

<details open><summary>Core</summary>

| Shortcut          | Mode   | Description                                              | plugin             |
|-------------------|--------|----------------------------------------------------------|--------------------|
| `CTRL`+`o`        | N      | Cursor moves back to previous position                   | Vim                |
| `CTRL`+`i`        | N      | Cursor moves back to next position                       | Vim                |
| `CTRL`+`6`        | N      | Toggle between previous file with                        | Vim                |
| `ALT`+`l`         | N      | Go to beginning of the line                              | Custom             |
| `ALT`+`h`         | N      | Go to end of the line                                    | Custom             |
| `CTRL`+`q`        | N      | Exit terminal mode                                       | Custom             |
| `CTRL`+`m`        | N      | Move argument/function                                   | Treesitter         |
| `leader`+`e`      | N      | Toggle file explorer                                     | nvim-tree          |
| `leader`+`k`      | N      | Keep only current split                                  | Vim                |
| `leader`+`z`      | N      | Open plugin manager                                      | lazy.nvim          |
</details>

<details open><summary>LSP</summary>

| Shortcut      | Mode | Description                     | Plugin        |
|---------------|------|---------------------------------|---------------|
| `gd`          | N    | Go to symbol definition         | LSP           |
| `gD`          | N    | Go to symbol declaration        | LSP           |
| `gI`          | N    | Go to symbol implementation     | LSP           |
| `gT`          | N    | Go to type definition           | LSP           |
| `leader`+`ld` | N    | Hover diagnostics               | LSP           |
| `leader`+`lD` | N    | Search diagnostics              | Telescope     |
| `leader`+`ls` | N    | Document symbols                | LSP           |
| `leader`+`lS` | N    | Document workspace symbols      | LSP           |
| `leader`+`lr` | N    | Rename current symbol           | LSP           |
| `leader`+`lp` | N    | Peek symbol definition          | LSP           |
| `leader`+`la` | N    | Code action                     | LSP           |
| `leader`+`lh` | N    | Signature help                  | LSP           |
| `leader`+`lf` | N    | Format buffer                   | conform.nvim  |
| `leader`+`lF` | N    | Format modifications only       | LSP           |
| `leader`+`lm` | N    | Format modifications            | conform.nvim  |
| `leader`+`lo` | N    | Symbol outlines                 | lspsaga       |
| `leader`+`lc` | N    | Incoming calls                  | telescope     |
| `leader`+`lC` | N    | Outgoing calls                  | telescope     |
| `leader`+`lw` | N    | Add folder to workplace         | LSP           |
| `leader`+`lW` | N    | List folder to workplace        | LSP           |
| `leader`+`lz` | N    | Lsp info                        | LSP           |
| `leader`+`lZ` | N    | Lsp restart                     | LSP           |
</details>

<details open><summary>Jumping</summary>

| Shortcut | Mode | Description | Plugin |
|----------|------|-------------|--------|
| `{`     | N    | Jump to prev paragraph | Vim |
| `}`     | N    | Jump to next paragraph | Vim |
| `[[`     | N    | Jump to prev section | Vim |
| `]]`     | N    | Jump to next section | Vim |
| `['`     | N    | Jump to treesitter context | Treesitter |
| `[a`     | N    | Jump to prev parameter/argument | Treesitter |
| `]a`     | N    | Jump to next parameter/argument | Treesitter |
| `[b`     | N    | Jump to prev buffer | Vim |
| `]b`     | N    | Jump to next buffer | Vim |
| `[t`     | N    | Jump to prev tab | Vim |
| `]t`     | N    | Jump to next tab | Vim |
| `[c`     | N    | Jump to prev class start | Treesitter |
| `]c`     | N    | Jump to next class start | Treesitter |
| `[C`     | N    | Jump to prev class end | Treesitter |
| `]C`     | N    | Jump to next class end | Treesitter |
| `[f`     | N    | Jump to prev function call start | Treesitter |
| `]f`     | N    | Jump to next function call start | Treesitter |
| `[F`     | N    | Jump to prev function call end | Treesitter |
| `]F`     | N    | Jump to next function call end | Treesitter |
| `[i`     | N    | Jump to prev condition start | Treesitter |
| `]i`     | N    | Jump to next condition start | Treesitter |
| `[I`     | N    | Jump to prev condition end | Treesitter |
| `]I`     | N    | Jump to next condition end | Treesitter |
| `[l`     | N    | Jump to prev loop start | Treesitter |
| `]l`     | N    | Jump to next loop start | Treesitter |
| `[L`     | N    | Jump to prev loop end | Treesitter |
| `]L`     | N    | Jump to next loop end | Treesitter |
| `[m`     | N    | Jump to prev method start | Treesitter |
| `]m`     | N    | Jump to next method start | Treesitter |
| `[M`     | N    | Jump to prev method end | Treesitter |
| `]M`     | N    | Jump to next method end | Treesitter |
| `[d`     | N    | Jump to prev diagnostic  | LSP |
| `]d`     | N    | Jump to next diagnostic | LSP |
| `[h`     | N    | Jump to prev git hunk | Gitsigns |
| `]h`     | N    | Jump to next git hunk | Gitsigns |
| `[o`     | N    | Jump to prev location | Vim |
| `]o`     | N    | Jump to next location | Vim |
| `[O`     | N    | Jump to first location | Vim |
| `]O`     | N    | Jump to last location | Vim |
| `[p`     | N    | Jump to indent top | mini.indentscope |
| `]p`     | N    | Jump to indent bottom | mini.indentscope |
| `[q`     | N    | Jump to prev quickfix | Vim |
| `]q`     | N    | Jump to next quickfix | Vim |
| `[Q`     | N    | Jump to first quickfix | Vim |
| `]Q`     | N    | Jump to last quickfix | Vim |
| `[s`     | N    | Jump to prev misspelled word | Vim |
| `]s`     | N    | Jump to next missspelled word | Vim |
| `[r`     | N    | Jump to prev reference| vim-illuminate |
| `]r`     | N    | Jump to next reference | vim-illuminate |
| `].`     | N    | Swap with next parameter | Treesitter |
| `[.`     | N    | Swap with prev parameter | Treesitter |
| `],`     | N    | Swap with next function | Treesitter |
| `[,`     | N    | Swap with prev function | Treesitter |
| `['`     | N    | Goto treesitter context | Treesitter Context |
</details>

<details open><summary>Editing</summary>

| Shortcut | Mode | Description | Plugin |
|----------|------|-------------|--------|
| `ys`     | N    | Surround word | vim-surround |
| `cs`     | N    | Change surround | vim-surround |
| `ds`     | N    | Delete surround | vim-surround |
| `s`      | V    | Surround selection | vim-surround |
| `S`      | V    | Surround line | vim-surround |

</details>

<details open><summary>Plugins</summary>

#### Persistence
| Shortcut | Mode | Description | Plugin |
|----------|------|-------------|--------|
| `leader` + `ps` | N | Restore session from current directory | persistence.nvim |
| `leader` + `pl` | N | Restore last session                   | persistence.nvim |
| `leader` + `pd` | N | Stop Persistence                       | persistence.nvim |

#### Telescope
| Mappings     | Action                                                    |
| ------------ | --------------------------------------------------------- |
| `<C-n>/<Down>` | Next item                                                 |
| `<C-p>/<Up>`   | Previous item                                             |
| `j/k`          | Next/previous (in normal mode)                            |
| `H/M/L`        | Select High/Middle/Low (in normal mode)                   |
| `gg/G`         | Select the first/last item (in normal mode)               |
| `<CR>`         | Confirm selection                                         |
| `<C-x>`        | Go to file selection as a split                           |
| `<C-v>`        | Go to file selection as a vsplit                          |
| `<C-u>`        | Scroll up in preview window                               |
| `<C-d>`        | Scroll down in preview window                             |
| `<C-f>`        | Scroll left in preview window                             |
| `<C-k>`        | Scroll right in preview window                            |
| `<M-f>`        | Scroll left in results window                             |
| `<M-k>`        | Scroll right in results window                            |
| `<C-/>`        | Show mappings for picker actions (insert mode)            |
| `?`            | Show mappings for picker actions (normal mode)            |
| `<C-c>`        | Close telescope (insert mode)                             |
| `<Esc>`        | Close telescope (in normal mode)                          |
| `<Tab>`        | Toggle selection and move to next selection               |
| `<S-Tab>`      | Toggle selection and move to prev selection               |
| `<C-q>`        | Send all items not filtered to quickfixlist (qflist)      |
| `<M-q>`        | Send all selected items to qflist                         |
| `<C-r><C-w>`   | Insert cword in original window into prompt (insert mode) |
| `<C-t>`        | Open in Trouble                                           |
| `<C-s>`        | Toggle Flash search                                       |

#### NavBuddy
| Mappings     | Action                                                    |
| ------------ | --------------------------------------------------------- |
| `<Esc>`        | Close and cusor to original location                      |
| `q`            | Quit                                                      |
| `j/k`          | Move Up or Down                                           |
| `h/l`          | Move to left/right panel                                  |
| `0`            | Move to first panel                                       |
| `r`            | Rename current focused symbol                             |
| `v/V`          | Visual selection of name/scope                            |
| `y/Y`          | Yank name/scope to system clipboard "+                    |
| `i/I`          | Insert at start of name/scope                             |
| `a/A`          | Insert at end of name/scope                               |
| `d`            | Delete scope                                              |
| `f/F`          | Create/Delete fold of current scope                       |
| `c`            | Comment out current scope                                 |
| `<Enter>/o`    | Go to selected symbol                                     |
| `J/K`          | Move focused node down/up                                 |
| `s`            | Show preview of current node                              |
| `<C-v>`        | Open selected node in a vertical split                    |
| `<C-x>`        | Open selected node in a horizontal split                  |
| `t`            | Open telescope                                            |
| `?`            | Open mappings help window                                 |

#### Outline
| Mappings     | Action                                                    |
| ------------ | --------------------------------------------------------- |
| Esc / q      | Close outline                                             |
| Enter        | Go to symbol location in code                             |
| o            | Go to symbol location in code without losing focus        |
| Shift+Enter  | Go to symbol location in code and close outline           |
| Ctrl+g       | Update outline window to focus on code location           |
| K            | Toggles the current symbol preview                        |
| Ctrl+Space   | Hover current symbol (provider action)                    |
| r            | Rename symbol                                             |
| a            | Code actions                                              |
| h            | Fold symbol or parent symbol                              |
| Tab          | Toggle fold under cursor                                  |
| Shift+Tab    | Toggle all folds                                          |
| l            | Unfold symbol                                             |
| W            | Fold all symbols                                          |
| E            | Unfold all symbols                                        |
| R            | Reset all folding                                         |
| Ctrl+k       | Go up and peek location                                   |
| Ctrl+j       | Go down and peek location                                 |
| ?            | Show current keymaps in a floating window                 |

</details>
