return {
  "echasnovski/mini.nvim",
  version = "*",
  event = "InsertEnter",
  keys = {
    { "ga", mode = { "n", "x" } },
    { "gA", mode = { "n", "x" } },
  },
  config = function()
    require("mini.align").setup()

    local pairs = require("mini.pairs")
    pairs.setup()
    pairs.unmap("i", "'", "''")
    pairs.unmap("i", "`", "``")
  end,
}
