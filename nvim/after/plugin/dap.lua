-- DAP (Debug Adapter Protocol) — manual config
local ok_dap, dap = pcall(require, "dap")
if not ok_dap then return end

local ok_vt, dap_vt = pcall(require, "nvim-dap-virtual-text")
if ok_vt then
  dap_vt.setup({})
end

local ok_ui, dapui = pcall(require, "dapui")
if ok_ui then
  dapui.setup({})
  dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
  dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
  dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
end

-- Python adapter
dap.adapters.python = {
  type = "executable",
  command = vim.fn.stdpath("data") .. "/mason/bin/debugpy-adapter",
}
dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    pythonPath = function()
      return vim.fn.exepath("python") or "/usr/bin/python"
    end,
  },
}

-- C/C++ adapter (codelldb)
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
    args = { "--port", "${port}" },
  },
}
dap.configurations.c = {
  {
    name = "Launch",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}
dap.configurations.cpp = dap.configurations.c

-- Keymaps
local map = vim.keymap.set
local opts = { silent = true }

map("n", "<leader>dc", dap.continue, vim.tbl_extend("force", opts, { desc = "DAP continue" }))
map("n", "<leader>do", dap.step_over, vim.tbl_extend("force", opts, { desc = "DAP step over" }))
map("n", "<leader>di", dap.step_into, vim.tbl_extend("force", opts, { desc = "DAP step into" }))
map("n", "<leader>dO", dap.step_out, vim.tbl_extend("force", opts, { desc = "DAP step out" }))
map("n", "<leader>db", dap.toggle_breakpoint, vim.tbl_extend("force", opts, { desc = "DAP toggle breakpoint" }))
map("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, vim.tbl_extend("force", opts, { desc = "DAP conditional breakpoint" }))
map("n", "<leader>dr", dap.repl.open, vim.tbl_extend("force", opts, { desc = "DAP open REPL" }))
map("n", "<leader>dl", dap.run_last, vim.tbl_extend("force", opts, { desc = "DAP run last" }))
map("n", "<leader>dt", dap.terminate, vim.tbl_extend("force", opts, { desc = "DAP terminate" }))
if ok_ui then
  map("n", "<leader>du", dapui.toggle, vim.tbl_extend("force", opts, { desc = "DAP UI toggle" }))
end
