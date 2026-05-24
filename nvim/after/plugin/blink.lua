-- blink.cmp: auto-completion
local ok, blink = pcall(require, "blink.cmp")
if not ok then return end

blink.setup({
  keymap = {
    preset = 'super-tab',
    ['<CR>'] = { 'accept', 'fallback' },
  },
  appearance = {
    nerd_font_variant = 'normal',
  },
  sources = {
    default = { 'lsp', 'path', 'buffer', 'luasnip' },
    providers = {
      luasnip = { name = 'LuaSnip', module = 'blink.compat.source' },
    },
  },
  snippets = { preset = 'luasnip' },
  signature = { enabled = true },
})
