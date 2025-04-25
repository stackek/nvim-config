return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function ()
            local npairs = require("nvim-autopairs")
            npairs.setup({
                disable_filetype = { "TelescopePrompt" },  -- general disable for filetypes
                enable_check_bracket_line = false,         -- kind of like "disable_when_touch"
                ignored_next_char = "[%w%.]",              -- allows smarter behavior
            })

            -- Add rules or disable specific characters in specific filetypes
            local Rule = require("nvim-autopairs.rule")

            -- Remove the default single quote rule, then re-add with a condition
            npairs.get_rules("'")[1].not_filetypes = { "markdown" }
        end
    },
    {
        "kylechui/nvim-surround",
        version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup()
        end
    }
  }
