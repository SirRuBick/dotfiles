local Utils = {}

function Utils.input_args()
  local argument_string = vim.fn.input("Program arg(s) (enter nothing to leave it null): ")
  return vim.fn.split(argument_string, " ", true)
end

function Utils.input_exec_path()
  return vim.fn.input("Path to executable (default to 'progout'): ", vim.fn.expand("%:p:h") .. "/progout", "file")
end

function Utils.input_file_path()
  return vim.fn.input("Path to debuggee (default to the current file): ", vim.fn.expand("%:p"), "file")
end

return Utils

