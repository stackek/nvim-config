return {
  {
    "williamboman/mason.nvim",
    config = function()
        require('mason').setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
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
            ensure_installed = {'basedpyright', 'lua_ls', 'clangd', 'marksman'},
        })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
            --initializing servers in nvim session
        require'lspconfig'.basedpyright.setup{
        }
        require'lspconfig'.lua_ls.setup{
        }
        require'lspconfig'.clangd.setup{
        }
        require'lspconfig'.marksman.setup{
        }
    end
  },
}
