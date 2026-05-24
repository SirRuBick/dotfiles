-- Obsess focus panel
local ok, obsess = pcall(require, "obsess")
if not ok then return end

obsess.setup({
  position = "center",
  window = {
    width = 60,
    height = 15,
    title = "Obsess",
  },
  flash = {
    times = 15,
    interval_ms = 200,
  },
})

local map = vim.keymap.set
map("n", "<leader>os", "<cmd>ObsessToggle<CR>", { desc = "Toggle focus panel" })
map("n", "<leader>oc", "<cmd>ObsessClose<CR>", { desc = "Close focus panel" })
map("n", "<leader>oo", "<cmd>ObsessTimer<CR>", { desc = "Set timer (minutes)" })
map("n", "<leader>ol", "<cmd>ObsessTimerSec<CR>", { desc = "Set timer (seconds)" })
map("n", "<leader>oa", "<cmd>ObsessTaskAdd<CR>", { desc = "Add task" })
map("n", "<leader>ot", "<cmd>ObsessTaskDone<CR>", { desc = "Toggle task done" })
map("n", "<leader>od", "<cmd>ObsessTaskDel<CR>", { desc = "Delete task" })
map("n", "<leader>oe", "<cmd>ObsessTaskClear<CR>", { desc = "Clear all tasks" })
