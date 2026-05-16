return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  dependencies = {
    "neovim-treesitter/treesitter-parser-registry",
  },
  config = function()
    require("nvim-treesitter").setup({
      install_dir = vim.fn.stdpath("config") .. "/treesitter",
    })

    vim.treesitter.language.register("systemverilog", { "systemverilog", "verilog" })
    vim.treesitter.language.register("pss", { "pss" })

    local group = vim.api.nvim_create_augroup("UserTreesitterMain", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = "*",
      callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)

        local ft = vim.bo[ev.buf].filetype
        if ft == "systemverilog" or ft == "verilog" or ft == "pss" then
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
