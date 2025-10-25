-- lsp features for code embedded in text documents
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
        pattern = { "*.md", "*.qmd" },
        callback = function()
          require("otter").activate({"R", "python", "lua", "bash", "cpp" })
        end,
      })
    end,
  }
}
