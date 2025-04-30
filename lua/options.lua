-- Hint: use `:h <option>` to figure out the meaning if needed
vim.opt.clipboard = 'unnamedplus'   -- use system clipboard 
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.mouse = 'a'                 -- allow the mouse to be used in Nvim

-- Tab
vim.opt.tabstop = 4                 -- number of visual spaces per TAB
vim.opt.softtabstop = 4             -- number of spacesin tab when editing
vim.opt.shiftwidth = 4              -- insert 4 spaces on a tab
vim.opt.expandtab = true            -- tabs are spaces, mainly because of python

-- UI config
vim.opt.number = true               -- show absolute number
vim.opt.relativenumber = true       -- add numbers to each line on the left side
vim.opt.cursorline = true           -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true           -- open new vertical split bottom
vim.opt.splitright = true           -- open new horizontal splits right
vim.opt.showmode = false            -- we are experienced, wo don't need the "-- INSERT --" mode hint

-- Searching
vim.opt.incsearch = true            -- search as characters are entered
vim.opt.hlsearch = true            -- highlight matches
vim.opt.ignorecase = true           -- ignore case in searches by default
vim.opt.smartcase = true            -- but make it case sensitive if an uppercase is entered


-- disable trailing comment when entering newline
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({"c", "r", "o"})
  end,
})

-- Define a global variable to track the state
vim.g.md2pdf_enabled = 0

-- Command to toggle the behavior on or off
vim.api.nvim_create_user_command('TogglePandoc', function()
    if vim.g.md2pdf_enabled == 0 then
        vim.g.md2pdf_enabled = 1
        print("Markdown to Latex auto-compiling ENABLED")
        -- Add the autocommand for .md files to trigger on save
        vim.api.nvim_create_augroup('md2pdf_on_save', { clear = true })
        vim.api.nvim_create_autocmd('BufWritePost', {
            group = 'md2pdf_on_save',
            pattern = '*.md',
            callback = function()
                local input_file = vim.fn.expand('%')
                local output_file = vim.fn.expand('%:r') .. '.latex'
                local file_dir = vim.fn.expand('%:p:h')
                local defaults_path = file_dir .. '/../pandoc/defaults.yaml'
                local cmd = string.format(
                    "!fish -c 'pandoc %s -o %s --defaults \"%s\" --standalone --embed-resources'",
                    input_file,
                    output_file,
                    defaults_path
                )
                vim.cmd(cmd)
            end
        })
    else
        vim.g.md2pdf_enabled = 0
        print("Markdown to Latex auto-compiling DISABLED")
        -- Remove the autocommand
        vim.api.nvim_del_augroup_by_name('md2pdf_on_save')
    end
end, {})
