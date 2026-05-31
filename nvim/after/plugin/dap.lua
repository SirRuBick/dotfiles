-- DAP (Debug Adapter Protocol) — lazy-loaded on first key press
-- Stub keymaps trigger load_dap(), which sets up dap/dapui/dap-vt
-- and rebinds the stubs to direct DAP function calls.

local _loaded = false
local opts = { silent = true }

-- Cross-platform executable path from Mason install
local function mason_bin(name)
  local base = vim.fn.stdpath("data") .. "/mason/bin/" .. name
  return vim.fn.exepath(base) ~= "" and vim.fn.exepath(base) or base
end

--- Called on first DAP key press — loads DAP, DAP-UI, DAP-virtual-text
local function load_dap()
  if _loaded then return end
  _loaded = true

  local ok_dap, dap = pcall(require, "dap")
  if not ok_dap then return end

  local ok_ui, dapui = pcall(require, "dapui")
  if ok_ui then
    dapui.setup({})
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end

  local ok_vt, dap_vt = pcall(require, "nvim-dap-virtual-text")
  if ok_vt then
    dap_vt.setup({})
  end

  -- Python adapter
  dap.adapters.python = {
    type = "executable",
    command = mason_bin("debugpy-adapter"),
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

  -- C/C++ adapter
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = mason_bin("codelldb"),
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

  -- Rebind stubs to direct DAP calls
  local map = vim.keymap.set
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
end

-- Stub keymaps — load DAP on first press, then execute
local map = vim.keymap.set
map("n", "<leader>dc", function() load_dap(); require("dap").continue() end, vim.tbl_extend("force", opts, { desc = "DAP continue" }))
map("n", "<leader>do", function() load_dap(); require("dap").step_over() end, vim.tbl_extend("force", opts, { desc = "DAP step over" }))
map("n", "<leader>di", function() load_dap(); require("dap").step_into() end, vim.tbl_extend("force", opts, { desc = "DAP step into" }))
map("n", "<leader>dO", function() load_dap(); require("dap").step_out() end, vim.tbl_extend("force", opts, { desc = "DAP step out" }))
map("n", "<leader>db", function() load_dap(); require("dap").toggle_breakpoint() end, vim.tbl_extend("force", opts, { desc = "DAP toggle breakpoint" }))
map("n", "<leader>dB", function() load_dap(); require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, vim.tbl_extend("force", opts, { desc = "DAP conditional breakpoint" }))
map("n", "<leader>dr", function() load_dap(); require("dap").repl.open() end, vim.tbl_extend("force", opts, { desc = "DAP open REPL" }))
map("n", "<leader>dl", function() load_dap(); require("dap").run_last() end, vim.tbl_extend("force", opts, { desc = "DAP run last" }))
map("n", "<leader>dt", function() load_dap(); require("dap").terminate() end, vim.tbl_extend("force", opts, { desc = "DAP terminate" }))
map("n", "<leader>du", function() load_dap(); pcall(require("dapui").toggle) end, vim.tbl_extend("force", opts, { desc = "DAP UI toggle" }))
