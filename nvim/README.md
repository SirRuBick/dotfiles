# Neovim config
This is my personal Neovim config.<br>
I am still adding things in as I learn more about Neovim.<br>

## Plugins
+ [Lazy.nvim](https://github.com/folke/lazy.nvim): Plugin Manager

## Requirements
+ neovim 0.9.4
+ [nerdfont](https://www.nerdfonts.com/cheat-sheet)
+ [git](https://git-scm.com/)
+ [ripgrep](https://github.com/BurntSushi/ripgrep)
+ [glow](https://github.com/charmbracelet/glow): required by Glow
+ [nodejs](https://github.com/nodejs): required by github Copliot
- [wget](https://www.gnu.org/software/wget/): required by mason.nvim
- wsl-open(wsl) or pngpaste(mac) or xclip/wl-clipboard: Obsidian
- Mason requires NPM to install packages

### On Windows
- requires luarocks: scoop install luarocks
- requires rigpgrep
- winget install nodejs.nodejs
- c compiler: winget install zig.zig

## TODO
- [ ] autocompletion key (tab) conflict with Snippets jumps, you cannot finish a completion when editing within snippets
- [ ] more luasnips, nice examples on github page for comments
- [ ] dadbob ui close should also close dbout and sql query
- [ ] Can you random between sub-colorschemes like nordfox?
- [ ] perhaps I don't need so much keymap for persisted
- [ ] update doc
- [ ] learn neogit
- [ ] use none-ls to replace conform + nvim-lint

### Plugins to explore
| Section  | Plugins | Notes |
|----------|---------|-------|
| editing  | "kevinhwang91/nvim-bqf" | better qf, possible to replace trouble? |
| editing  | "danymat/neogen" | comment generator |
| editing  | "echasnovski/mini.align" | align text |
| editing  | "junegunn/vim-easy-align" | align text |
| tools    | "rest-nvim/rest.nvim" | replace of postman |
| ui       | "karb94/neoscroll.nvim" | smooth scroll |
| test     | "nvim-neotest/neotest" | test code block |
| lang     | "ekickx/clipboard-image.nvim" | paste image to markdown |
| lang     | "chrisbra/csv.vim" | csv file |
| others   | "itchyny/calendar.vim" | |

## Unused Keymaps

<details open><summary>Unused</summary>

| Key | Mode |
| ---- | ---- |
| `CTRL` + `s` | Normal |
| `CTRL` + `@` | Normal |
| `CTRL` + `n` | Normal |
| `CTRL` + `[` | Normal |
| `CTRL` + `_` | Normal |
| `Y` | Normal |
| `_` | Normal |
</details>
