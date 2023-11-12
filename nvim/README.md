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
- setup filetype plugins
- setup plugins for tags and marks
- config nvim-cmp better
- "folke/zen-mode.nvim"
- "preservim/vim-markdown" and "iamcco/markdown-preview.nvim"
- smarter yank and clipboard
- config nvim-notify
- project management(integrated with telescope)

### possible improvements
- more telescope plugins? and pickers?
- "stevearc/aerial.nvim"?
- "simrat39/symbols-outline.nvim" is quite useful but can lspsaga do the same or not?
- "joechrisellis/lsp-format-modifications.nvim" is useful but needs to be added to lsp keymap after it's cleaned

### Plugins to explore
- "folke/noice.nvim"
- "tpope/vim-dadbod", "kristijanhusak/vim-dadbod-ui", "'kristijanhusak/vim-dadbod-completion"
- "nvim-neorg/neorg"
- "ThePrimeagen/git-worktree.nvim"
- "xiyaowong/nvim-transparent"
- "numToStr/FTerm.nvim"
- "rmagatti/goto-preview"
- navarasu/onedark.nvi
- "tpope/vim-sleuth"
- "folke/twilight.nvim"
- "ThePrimeagen/refactoring.nvim"
- "nvim-pack/nvim-spectre"
- "stevearc/oil.nvim"
- "chentoast/marks.nvim"
- "ahmedkhalf/project.nvim"
- "Bekaboo/dropbar.nvim"
- "nvim-neorg/neorg" vs "nvim-orgmode/orgmode"
- "renerocksai/telekasten.nvim"
- "petertriho/nvim-scrollbar"
- "/mhartington/formatter.nvim" vs. "sbdchd/neoformat"
