# Neovim config
This is my personal neovim config.<br>
I am still adding things in as I lean more about nvim.<br>

## Plugins
+ [Lazy.nvim](https://github.com/folke/lazy.nvim): Plugin Manager

## Requirements
+ neovim 0.9.4
+ git
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
- document useful shortcuts
- ftplugin
- organize key maps
- dadboard ui close should also close dbout and sql query
- telescope current_buffer_fuzzy_find and others.

### Plugins to explore
| Section | Plugins |
|---------|---------|
| custom LLM | "David-Kunz/gen.nvim"|
| terminal integration | "akinsho/toggleterm.nvim"|
| coding enhancement  | "ThePrimeagen/harpoon" |
| coding enhancement | "chentoast/marks.nvim"|
| git | "ThePrimeagen/git-worktree.nvim"|
| formatter | "mhartington/formatter.nvim" |
| formatter | "sbdchd/neoformat" |
| formatter | "stevearc/conform.nvim" |
| file explorer | "stevearc/oil.nvim" |
| note taking | "epwalsh/obsidian.nvim" |
| note taking | "mickael-menu/zk-nvim" |
| note taking | "nvim-neorg/neorg" |
| note taking | "renerocksai/telekasten.nvim" |
| test | "nvim-neotest/neotest" |
