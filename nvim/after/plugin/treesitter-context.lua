-- nvim-treesitter-context: sticky function/class header
local ok, ctx = pcall(require, "treesitter-context")
if ok then
  ctx.setup({
    mode = "cursor",
    max_lines = 3,
    trim_scope = "outer",
  })
end
