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
            -- A list of servers to automatically install if they're not already installed
            ensure_installed = {'r_language_server', 'basedpyright', 'lua_ls', 'clangd',  'matlab_ls'},
        })
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

            --initializing servers in nvim session
        require'lspconfig'.basedpyright.setup{}
        require'lspconfig'.lua_ls.setup{
            settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim', 'pandoc' }
                        }
                    }
                }
        }
        require'lspconfig'.clangd.setup{}
        require'lspconfig'.r_language_server.setup{}
        require"lspconfig".matlab_ls.setup{}

    end,
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      update_in_insert = false,
      underline = true,
      severity_sort = false,
      float = true,
    })

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
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities.textDocument.completion.completionItem.resolveSupport = {
          properties = { "documentation", "detail", "additionalTextEdits" },
        }

        require("lspconfig").gopls.setup({ capabilities = capabilities })
        require("lspconfig").clangd.setup({ capabilities = capabilities })
        vim.cmd([[set mouse=a]])
        end,
  },
}
