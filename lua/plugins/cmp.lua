return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")

        local function jump_next(fallback)
          local luasnip = require "luasnip"
          if luasnip.locally_jumpable(1) then
            return luasnip.jump(1)
          else
            return fallback()
          end
        end

        local function jump_prev(fallback)
          local luasnip = require "luasnip"
          if luasnip.locally_jumpable(-1) then
            return luasnip.jump(-1)
          else
            return fallback()
          end
        end

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(jump_next, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(jump_prev, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
          { name = "luasnip" },
          { name = "madol" },
        }),
      })

        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on(
          'confirm_done',
          cmp_autopairs.on_confirm_done())
    end,
  },
}
