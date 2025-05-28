-- init.lua
-- Neovim setup with lazy.nvim, Ayu theme, JetBrains Mono font, fzf‑lua, blink.cmp, and which‑key.
-- Core editor *options* and *key‑maps* live in separate files:  `lua/options.lua` and `lua/keymaps.lua`.

---------------------------------------------------------------------
-- Leader key --------------------------------------------------------
vim.g.mapleader = " "

---------------------------------------------------------------------
-- Load settings ----------------------------------------------------
require("options")   -- see lua/options.lua
require("keymaps")   -- see lua/keymaps.lua

---------------------------------------------------------------------
-- Highlight on yank ------------------------------------------------
vim.api.nvim_create_autocmd("TextYankPost", {
  desc   = "Highlight when yanking text",
  group  = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

---------------------------------------------------------------------
-- Bootstrap lazy.nvim ----------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

---------------------------------------------------------------------
-- Plugin specification ---------------------------------------------
local plugins = {
 { import = 'plugins' } 
}

---------------------------------------------------------------------
-- Initialise lazy.nvim ---------------------------------------------
require("lazy").setup(plugins, {
  -- Place lazy.nvim options here if desired
})

---------------------------------------------------------------------
-- End of init.lua ---------------------------------------------------
