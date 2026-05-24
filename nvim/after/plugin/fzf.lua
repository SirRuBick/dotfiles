-- fzf-lua configuration and keymaps
local ok, fzf = pcall(require, "fzf-lua")
if not ok then return end

fzf.setup()

local map = vim.keymap.set

-- File finder
map("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Find buffers" })
map("n", "<leader>fo", "<cmd>FzfLua oldfiles<cr>", { desc = "Recent files" })
map("n", "<leader>fs", "<cmd>FzfLua grep_cword<cr>", { desc = "Grep word under cursor" })
map("n", "<leader>fk", "<cmd>FzfLua keymap<cr>", { desc = "Find keymaps" })
map("n", "<leader>fh", "<cmd>FzfLua helptags<cr>", { desc = "Find help tags" })

-- Project
local ok_proj, project = pcall(require, "project")
if ok_proj then
  project.setup({
    fzf_lua = { enabled = true },
    ignore_lsp = true,
  })
  map("n", "<leader>fp", "<cmd>ProjectFzf<cr>", { desc = "Find projects" })
end

-- Which-key
local ok_wk, wk = pcall(require, "which-key")
if ok_wk then
  wk.setup({ preset = "helix" })
  wk.add({
    { "<leader>e", group = " Oil" },
    { "<leader>b", group = "Buffers" },
    { "<leader>f", group = "Find" },
    { "<leader>c", group = "LSP" },
    { "<leader>q", group = "Quit" },
    { "<leader>w", group = "Windows" },
    { "<leader><tab>", group = "Tabs" },
    { "<leader>o", group = "Focus panel" },
    { "<leader>u", group = "Undotree" },
    { "<leader>l", group = "Project" },
    { "<leader>t", group = "Terminal" },
  })
end
