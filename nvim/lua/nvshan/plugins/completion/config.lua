local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")
local icons = {
  kind = require("icons")["kind"],
  type = require("icons")["type"],
  cmp = require("icons")["cmp"],
}

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local border_opts = {
  border = "single",
  winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
}


cmp.setup(
  {
    enabled = function()
      if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then
        return false
      end
      -- disable completion in comments
      local context = require("cmp.config.context")
      -- keep command mode completion enabled when cursor is in a comment
      if vim.api.nvim_get_mode().mode == "c" then
        return true
      else
        return not context.in_treesitter_capture("comment")
            and not context.in_syntax_group("Comment")
      end
    end,
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        -- require("snippy").expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ["<CR>"] = cmp.mapping.confirm { select = true },
      ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
      ["<Esc>"] = cmp.mapping.close(),
      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-y>"] = cmp.config.disable,
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        elseif check_backspace() then
          fallback()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp", priority = 1000 },
      { name = "luasnip",  priority = 750 },
      { name = "nvim_lua", priority = 750 },
      -- { name = "ultisnips", priority = 500 },
      -- { name = "cmp_tabnine", priority = 500 },
      { name = "copilot", priority = 500 },
      -- { name = "orgmode", priority = 500 },
      { name = "tmux", priority = 500 },
      { name = "treesitter", priority = 500 },
      -- { name = "latex_symbols", priority = 500 },
      -- { name = "emoji", priority = 500 },
      { name = "buffer",   priority = 500 },
      { name = "path",     priority = 250 },
    }),
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol", -- show only symbol annotations
        -- menu = {
        --   nvim_lsp = "[LSP]",
        --   ultisnips = "[US]",
        --   nvim_lua = "[LUA]",
        --   path = "[PATH]",
        --   buffer = "[BUFF]",
        --   emoji = "[Emoji]",
        --   omni = "[Omni]",
        --   cmp_tabnine = "[TN]",
				-- 	copilot = "[CPLT]",
				-- 	orgmode = "[ORG]",
				-- 	tmux = "[TMUX]",
				-- 	treesitter = "[TS]",
				-- 	latex_symbols = "[LTEX]",
				-- 	luasnip = "[SNIP]",
				-- 	spell = "[SPELL]",
        -- },
        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
  
        -- The function below will be called before any actual modifications from lspkind
        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
        before = function (entry, vim_item)
          local lspkind_icons = vim.tbl_deep_extend("force", icons.kind, icons.type, icons.cmp)
          vim_item.kind = string.format(" %s  %s", lspkind_icons[vim_item.kind] or icons.cmp.undefined, vim_item.kind or "")
          vim_item.menu = setmetatable({
            nvim_lsp = "[LSP]",
            ultisnips = "[US]",
            nvim_lua = "[LUA]",
            path = "[PATH]",
            buffer = "[BUFF]",
            emoji = "[Emoji]",
            omni = "[Omni]",
            cmp_tabnine = "[TN]",
            copilot = "[CPLT]",
            orgmode = "[ORG]",
            tmux = "[TMUX]",
            treesitter = "[TS]",
            latex_symbols = "[LTEX]",
            luasnip = "[SNIP]",
            spell = "[SPELL]",
          }, {
            __index = function()
              return "[BTN]" -- builtin/unknown source names
            end,
          })[entry.source.name]
          return vim_item
        end
      })
    },
    duplicates = {
      nvim_lsp = 1,
      luasnip = 1,
      cmp_tabnine = 1,
      buffer = 1,
      path = 1,
    },
    experimental = {
      ghost_text = { hl_group = "Whitespace" },
      native_menu = false,
    },
  })

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = "buffer" },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" }
  }
})

-- Use cmdline & path source for ":" (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" }
  }, {
    { name = "cmdline" }
  })
})
