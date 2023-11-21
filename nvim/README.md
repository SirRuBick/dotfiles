# Neovim config
This is my personal neovim config.<br>
I am still adding things in as I lean more about nvim.<br>

## Plugins
+ [Lazy.nvim](https://github.com/folke/lazy.nvim): Plugin Manager

## dependencies
+ git
+ ripgrep
+ nodejs( github copilot )

## Keymaps
Some of the shortcuts I use frequently are listed here. <br>
In the following shortcuts, `<leader>` represents `space`.<br>

| Shortcut          | Mode     | Description                                                              | plugin                      |
|-------------------|----------|--------------------------------------------------------------------------|-----------------------------|
| `CTRL`+`o`        | N        | Cursor moves back to previous position                                   | Vim                         |
| `CTRL`+`i`        | N        | Cursor moves back to next position                                       | Vim                         |
| `CTRL`+`6`        | N        | Toggle between previous file with                                        | Vim                         |


## TODO
- document useful shortcuts, including folding ones, Comment, etc.
- setup plugins for tags and marks
- config nvim-cmp better
- config nvim-notify
- paste in insert mode
- "joechrisellis/lsp-format-modifications.nvim" is useful but needs to be added to lsp keymap after it's cleaned

### Plugins to explore
| Section | Plugins |
|---------|---------|
|custom LLM| "David-Kunz/gen.nvim"|
| terminal integration| "akinsho/toggleterm.nvim"|
| markdown| "preservim/vim-markdown" and "iamcco/markdown-preview.nvim"|
| project | ahmedkhalf/project.nvim|
| coding support |"folke/zen-mode.nvim"|
| coding support | "folke/twilight.nvim" |
| coding support | "rmagatti/goto-preview" |
| coding enhancement | "stevearc/aerial.nvim"|
| coding enhancement | "simrat39/symbols-outline.nvim" is quite useful but can lspsaga do the same or not?|
| coding enhancement | "chentoast/marks.nvim"|
| git | "ThePrimeagen/git-worktree.nvim"|
|formatter | "/mhartington/formatter.nvim" vs. "sbdchd/neoformat" |
| file explorer | "stevearc/oil.nvim" |
| ui |  "petertriho/nvim-scrollbar" |
| ui | "Bekaboo/dropbar.nvim" |
| ui | "xiyaowong/nvim-transparent" |
| filetype | "tpope/vim-sleuth" |
| search and replace | "nvim-pack/nvim-spectre" |
| note taking | "nvim-neorg/neorg" |
| note taking | "renerocksai/telekasten.nvim" |
