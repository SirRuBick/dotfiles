-- Gitsigns: git gutter signs, blame, hunk actions
local ok, gitsigns = pcall(require, "gitsigns")
if not ok then return end

gitsigns.setup({
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  signcolumn = true,
  numhl = false,
  linehl = false,
  word_diff = false,
  watch_gitdir = { follow_files = true },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",
    delay = 1000,
    ignore_whitespace = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  max_file_length = 40000,
  preview_config = {
    border = "rounded",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
})

local map = vim.keymap.set
local opts = { silent = true }

-- Hunk navigation
map("n", "]h", gitsigns.next_hunk, vim.tbl_extend("force", opts, { desc = "Next git hunk" }))
map("n", "[h", gitsigns.prev_hunk, vim.tbl_extend("force", opts, { desc = "Prev git hunk" }))

-- Hunk actions
map("n", "<leader>gs", gitsigns.stage_hunk, vim.tbl_extend("force", opts, { desc = "Stage hunk" }))
map("v", "<leader>gs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, vim.tbl_extend("force", opts, { desc = "Stage hunk" }))
map("n", "<leader>gr", gitsigns.reset_hunk, vim.tbl_extend("force", opts, { desc = "Reset hunk" }))
map("v", "<leader>gr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, vim.tbl_extend("force", opts, { desc = "Reset hunk" }))
map("n", "<leader>gS", gitsigns.stage_buffer, vim.tbl_extend("force", opts, { desc = "Stage buffer" }))
map("n", "<leader>gu", gitsigns.undo_stage_hunk, vim.tbl_extend("force", opts, { desc = "Undo stage hunk" }))
map("n", "<leader>gR", gitsigns.reset_buffer, vim.tbl_extend("force", opts, { desc = "Reset buffer" }))
map("n", "<leader>gp", gitsigns.preview_hunk, vim.tbl_extend("force", opts, { desc = "Preview hunk" }))
map("n", "<leader>gb", function() gitsigns.blame_line({ full = true }) end, vim.tbl_extend("force", opts, { desc = "Blame line" }))
map("n", "<leader>gd", gitsigns.diffthis, vim.tbl_extend("force", opts, { desc = "Diff this" }))
map("n", "<leader>gD", function() gitsigns.diffthis("~") end, vim.tbl_extend("force", opts, { desc = "Diff this ~" }))
map("n", "<leader>gtb", gitsigns.toggle_current_line_blame, vim.tbl_extend("force", opts, { desc = "Toggle line blame" }))
map("n", "<leader>gtd", gitsigns.toggle_deleted, vim.tbl_extend("force", opts, { desc = "Toggle deleted" }))
