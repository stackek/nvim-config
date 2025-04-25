return {
  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("otter").setup()

      vim.api.nvim_create_autocmd("BufReadPost", {
        pattern = "*.md",
        callback = function()
          require("otter").activate({ "python", "lua", "bash", "cpp" })
        end,
      })
    end,
  }
}
