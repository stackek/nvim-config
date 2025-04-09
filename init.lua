local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" --lazyvim
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "plugins" },
      },
}
)

require('options')
require('keymaps')
require('colorscheme')
require("nvim-surround").setup()
require("autoclose").setup({
   keys = {
      ["`"] = { escape = false, close = false, pair = "``", disabled_filetypes = {} },
   },
})
