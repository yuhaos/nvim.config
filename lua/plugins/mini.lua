return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    require("mini.align").setup()

    local pairs = require("mini.pairs")
    pairs.setup()
    pairs.unmap("i", "'", "''")
    pairs.unmap("i", "`", "``")
  end,
}
