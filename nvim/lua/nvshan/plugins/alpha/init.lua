return {
  {
    "goolord/alpha-nvim",
    event = "BufWinEnter",
    config = function()
      require("nvshan.plugins.alpha.config")
    end,
  }
}
