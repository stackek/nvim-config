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
          local t = ls.text_node
          local i = ls.insert_node
          local _local_1_ = require("luasnip.extras.fmt") local fmta = _local_1_["fmta"]
          local ssm = ls.extend_decorator.apply(ls.snippet, {condition = is_math, snippetType = "autosnippet"})
          local ssn = ls.extend_decorator.apply(ls.snippet, {condition = not_math, snippetType = "autosnippet"})

          local function sm(...) return table.insert(snippets, ssm(...)) end
          local function sn(...) return table.insert(snippets, ssn(...)) end

          --Non-math snippets
          sn({trig = "cmm", name = "Caution Block"}, fmta(
            "::: {.caution title=\"<>\" ref=\"<>\"}\n<>\n:::",
            {i(1), i(2), i(3)}
          ))

          sn({trig = "tmm", name = "Theorem Block"}, fmta(
            "::: {.theorem title=\"<>\" ref=\"<>\"}\n<>\n:::",
            {i(1), i(2), i(3)}
          ))

          sn({trig = "emm", name = "Example Block"}, fmta(
            "::: {.example title=\"<>\" ref=\"<>\"}\n<>\n:::",
            {i(1), i(2), i(3)}
          ))

          sn({trig = "lmm", name = "Lemma block"}, fmta(
            "::: {.lemma title=\"<>\" ref=\"<>\"}\n<>\n:::",
            {i(1), i(2), i(3)}
          ))

          sn({trig = "pmm", name = "Proof block"}, fmta(
            "::: {.proof title=\"<>\" ref=\"<>\"}\n<>\n:::",
            {i(1), i(2), i(3)}
          ))

          sn({trig = "dff", name = "Definition block"}, fmta(
            "::: {.definition title=\"<>\" ref=\"<>\"}\n<>\n:::",
            {i(1), i(2), i(3)}
          ))

          sn({trig = "nmm", name = "Notes block"}, fmta(
            "::: {.notes}\n<>\n:::",
            {i(1)}
          ))

          sn({trig = "cdd", name = "Code Block"}, fmta(
            "```<>\n<>\n```",
            {i(1), i(2)}
          ))

          sn({trig = "rff", name = "Reference"}, fmta(
            "\\ref{<>}",
            {i(1)}
          ))

          sn({trig = "bbb", name = "Bold"}, fmta(
            "**<>**",
            {i(1)}
          ))

          sn({trig = "iii", name = "Italic"}, fmta(
            "*<>*",
            {i(1)}
          ))

          --Math snippets
          sm({trig = "appr", name = "Approximately equal"}, t(
            "\\approx ",
            {}
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
            quarto = {
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
        end,
    }
}
