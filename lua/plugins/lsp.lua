return {
  {
    "williamboman/mason.nvim",
    config = function()
      require('mason').setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "->",
            package_uninstalled = "x"
          }
        }
      })
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'r_language_server', 'basedpyright', 'lua_ls', 'clangd', 'matlab_ls' },
      })

      -- fish LSP: manually started
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'fish',
        callback = function()
          vim.lsp.start({
            name = 'fish-lsp',
            cmd = { 'fish-lsp', 'start' },
            cmd_env = { fish_lsp_show_client_popups = false },
          })
        end,
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    experimental = { ghost_text = true },
    config = function()
      -- Lua LS with settings
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim", "pandoc" }
            }
          }
        }
      })

      -- Other servers (no extra config)
      vim.lsp.config("basedpyright", {})
      vim.lsp.config("clangd", {})
      vim.lsp.config("r_language_server", {})
      vim.lsp.config("matlab_ls", {})

      -- Enable them
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("basedpyright")
      vim.lsp.enable("clangd")
      vim.lsp.enable("r_language_server")
      vim.lsp.enable("matlab_ls")

      -- Diagnostics UI
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = false,
        float = true,
      })
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function ()
      local signature_config = {
        debug = true,
        hint_enable = false,
        handler_opts = { border = "single" },
        max_width = 80,
      }

      require("lsp_signature").setup(signature_config)

      -- Capabilities for servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = { "documentation", "detail", "additionalTextEdits" },
      }

      -- Now register gopls + clangd with capabilities
      vim.lsp.config("gopls", { capabilities = capabilities })
      vim.lsp.config("clangd", { capabilities = capabilities })
      vim.lsp.enable("gopls")
      vim.lsp.enable("clangd")

      vim.cmd([[set mouse=a]])
    end,
  },
}
