return{
    {
        "max397574/startup.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope-file-browser.nvim" },
          config = function()
            require "startup".setup()
            require"startup".create_mappings({
              ["<leader>ff"]="<cmd>Telescope find_files<CR>",
              ["<leader>gg"]="<cmd>Telescope live_grep<CR>"
            })
          end
    }
}
