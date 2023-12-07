return {
  {
    "tpope/vim-dadbod",
    cmd = { "DB", "DBUI", "DBUIClose", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer", "DBUIRenameBuffer", "DBUILastQueryInfo" },
    dependencies = {
      {
        "kristijanhusak/vim-dadbod-ui",
        init = function()
          vim.g.db_ui_use_nerd_fonts = 1
        end
      },
      {
        "kristijanhusak/vim-dadbod-completion",
        ft = { "sql", "mysql", "plsql" },
      },
    },
    config = function()
      require("nvshan.plugins.sql.dadbod")
    end,
    keys = {
      { "<leader>qc", "<CMD>DBUIClose<CR>",                   desc = "Close DB UI" },
      { "<leader>qu", "<CMD>DBUIToggle<CR>",                  desc = "Toggle Dadbod UI" },
      { "<leader>qa", "<CMD>DBUIAddConnection<CR>",           desc = "DB Add Connection" },
      { "<leader>qf", "<CMD>DBUIFindBuffer<CR>",              desc = "DB UI Find Buffer" },
      { "<leader>qr", "<CMD>DBUIRenameBuffer<CR>",            desc = "DB UI Rename Buffer" },
      { "<leader>qq", "<CMD>DBUILastQueryInfo<CR>",           desc = "Last Query Info" },
      { "<leader>qe", "<CMD>e ~/dadbod/connections.json<CR>", desc = "Edit DB Connections" },
    },
  }
}
