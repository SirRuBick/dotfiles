# Neovim config
This is my personal neovim config.<br>
I am still adding things in as I lean more about nvim.<br>

## Plugins
+ [Lazy.nvim](https://github.com/folke/lazy.nvim): Plugin Manager

## Requirements
+ neovim 0.9.4
+ Nerdfont
+ Git
+ [ripgrep](https://github.com/BurntSushi/ripgrep)
+ [glow](https://github.com/charmbracelet/glow): required by Glow
+ nodejs: required by github Copliot

## Keymaps
Some of the shortcuts I use frequently are listed here. <br>
In the following shortcuts, `<leader>` represents `space`.<br>

| Shortcut          | Mode     | Description                                                              | plugin                      |
|-------------------|----------|--------------------------------------------------------------------------|-----------------------------|
| `CTRL`+`o`        | N        | Cursor moves back to previous position                                   | Vim                         |
| `CTRL`+`i`        | N        | Cursor moves back to next position                                       | Vim                         |
| `CTRL`+`6`        | N        | Toggle between previous file with                                        | Vim                         |
| `B`               | N        | Go to beginning of the line                                              | Vim                         |
| `E`               | N        | Go to end of the line                                                    | Vim                         |


## TODO
- nvim-lint autocmd can be ftplugin?
- use "WhoIsSethDaniel/mason-tool-installer.nvim" to manage linter and other dependencies?
- document useful shortcuts
- ftplugin
- organize key maps
- tab keymaps?
- split keymaps?
- python setup, jupyter keymap?

### BUGS
- wildfire or treesitter tries to select space around
- project is jumping dir for nonsense
- dadboard ui close should also close dbout and sql query

### Plugins to explore
| Section | Plugins |
|---------|---------|
| custom LLM | "David-Kunz/gen.nvim"|
| terminal integration | "akinsho/toggleterm.nvim"|
| coding | "ThePrimeagen/harpoon" |
| coding | "chentoast/marks.nvim" |
| coding | "rmagatti/alternate-toggler" |
| coding | "skywind3000/asyncrun.vim" |
| coding | "AckslD/swenv.nvim" |
| bookmark | "MattesGroeger/vim-bookmarks" |
| bookmark | "tom-anders/telescope-vim-bookmarks.nvim" |
| git | "ThePrimeagen/git-worktree.nvim"|
| file explorer | "stevearc/oil.nvim" |
| note taking | "epwalsh/obsidian.nvim" |
| note taking | "mickael-menu/zk-nvim" |
| note taking | "nvim-neorg/neorg" |
| note taking | "renerocksai/telekasten.nvim" |
| ui | "neovide/neovide" |
| test | "nvim-neotest/neotest" |
