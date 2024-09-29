return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          -- ensure_installed = { "bash", "cpp", "perl", "gitcommit", "make", "python", "yaml", "xml" },
          sync_install = false,
          auto_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
          -- disable = {"verilog", "systemverilog"},
        })
    end
}
