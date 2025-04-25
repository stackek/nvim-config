return {
    {
	'https://gitlab.com/repetitivesin/madol.nvim',
        dependencies = { "L3MON4D3/LuaSnip", "nvim-treesitter/nvim-treesitter" },
        config = function()
        local ls = require("luasnip")

        ls.config.setup({
        enable_autosnippets = true,
        store_selection_keys = "<Tab>",
        })

        function my_markdown_snippets(is_math, not_math)
          local snippets = {}
          -- local t = ls.text_node
          local i = ls.insert_node
          local _local_1_ = require("luasnip.extras.fmt") local fmta = _local_1_["fmta"]
          local ss = ls.extend_decorator.apply(ls.snippet, {condition = not_math, snippetType = "autosnippet"})

          local function s(...) return table.insert(snippets, ss(...)) end
          s({trig = "cmm", name = "Caution Block"}, fmta(
            "::: {.caution title=\"<>\" ref=\"<>\"}\n<>\n:::",
            {i(1), i(2), i(3)}
          ))

          s({trig = "tmm", name = "Theorem Block"}, fmta(
            "::: {.theorem title=\"<>\" ref=\"<>\"}\n<>\n:::",
            {i(1), i(2), i(3)}
          ))

          s({trig = "emm", name = "Example Block"}, fmta(
            "::: {.example title=\"<>\" ref=\"<>\"}\n<>\n:::",
            {i(1), i(2), i(3)}
          ))

          s({trig = "lmm", name = "Lemma Block"}, fmta(
            "::: {.lemma title=\"<>\" ref=\"<>\"}\n<>\n:::",
            {i(1), i(2), i(3)}
          ))

          s({trig = "cdd", name = "Code Block"}, fmta(
            "```<>\n<>\n```",
            {i(1), i(2)}
          ))

           return snippets
        end

        require("madol").setup({
            markdown = {
                snippets = {
                  -- Reminder: without brackets, my_markdown_snippets would be treated as
                  -- string
                  [my_markdown_snippets] = true,
                  ["image-pasting"] = true,
                },
              },
        })

            vim.keymap.set({ "s", "i" }, "<C-j>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                else
                    return "<C-j>"
                end
        end, { silent = true })
        vim.keymap.set({ "s", "i" }, "<C-k>", function()
            if ls.choice_active() then
                ls.change_choice(-1)
            else
                return "<C-k>"
            end
        end, { silent = true })
        -- vim.keymap.set({ "i", "s" }, "<Tab>", function()
        --     ls.jump(1)
        -- end, { silent = true })
        -- vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
        --     ls.jump(-1)
        -- end, { silent = true })
        end,
    }
}
