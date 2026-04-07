local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")
local icons = {
  kind = require("icons")["kind"],
  type = require("icons")["type"],
  cmp = require("icons")["cmp"],
}
local load_table_from_dir = require("utils").load_table_from_dir
local snippets_directory = require("settings").snippets_directory

require("luasnip.loaders.from_vscode").lazy_load()

for filetype, file_snippets in pairs(load_table_from_dir(snippets_directory)) do
  for _, snippet in ipairs(file_snippets) do
    luasnip.add_snippets(filetype, snippet)
  end
end

cmp.setup({
  -- enabled = function()
  --   if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then
  --     return false
  --   end
  --   -- disable completion in comments
  --   local context = require("cmp.config.context")
  --   -- keep command mode completion enabled when cursor is in a comment
  --   if vim.api.nvim_get_mode().mode == "c" then
  --     return true
  --   else
  --     return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
  --   end
  -- end,
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
    ["<C-p>"] = cmp.mapping.scroll_docs(-4),
    ["<C-n>"] = cmp.mapping.scroll_docs(4),
    ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Replace, select = false }),
    ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Relace, select = false }),
    ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Relace, select = false }),
    ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Replace, select = false }),
    ["<CR>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() then
          if cmp.get_active_entry() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
          elseif luasnip.expandable() then
            luasnip.expand()
          else
            fallback()
          end
        else
          fallback()
        end
      end,
      s = cmp.mapping.confirm({ select = true }),
      c = function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
          fallback()
        end
      end,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      elseif cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      elseif cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp", priority = 900 },
    { name = "luasnip", priority = 800 },
    { name = "copilot", priority = 700 },
    { name = "codeium", priority = 700 },
    { name = "buffer", priority = 600 },
    { name = "treesitter", priority = 500 },
    { name = "path", priority = 400 },
    { name = "spell", priority = 300 },
    { name = "emoji", priority = 200 },
    { name = "tmux", priority = 100 },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text", -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
      maxwidth = 80, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      show_labelDetails = true, -- show labelDetails in menu. Disabled by default
      symbol_map = vim.tbl_deep_extend("force", icons.kind, icons.type, icons.cmp),

      before = function(entry, vim_item)
        vim_item.menu = setmetatable({
          nvim_lsp = "[LSP]",
          luasnip = "[SNP]",
          copilot = "[CPT]",
          codeium = "[CDM]",
          buffer = "[BUF]",
          treesitter = "[TST]",
          path = "[PTH]",
          spell = "[SPL]",
          emoji = "[EMJ]",
          tmux = "[TMX]",
        }, {
          __index = function()
            return "[UKN]" -- builtin/unknown source names
          end,
        })[entry.source.name]
        return vim_item
      end,
    }),
  },
  experimental = {
    ghost_text = true,
  },
})

-- Set configuration for specific filetype.
-- cmp.setup.filetype("gitcommit", {
--   sources = cmp.config.sources({
--     { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
--   }, {
--     { name = "buffer" },
--   }),
-- })

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ":" (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
