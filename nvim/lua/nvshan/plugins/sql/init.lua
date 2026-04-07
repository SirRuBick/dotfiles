return {
  {
    "tpope/vim-dadbod",
    cmd = { "DB", "DBUI", "DBUIClose", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer", "DBUIRenameBuffer", "DBUILastQueryInfo" },
    dependencies = {
      {
        "kristijanhusak/vim-dadbod-ui",
        init = function()
          vim.g.db_ui_use_nerd_fonts = 1
        end,
      },
      {
        "kristijanhusak/vim-dadbod-completion",
        ft = { "sql", "mysql", "plsql" },
      },
    },
    config = function()
      require("nvshan.plugins.sql.dadbod")
    end,
  },
}
