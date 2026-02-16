-- Bootstrap lazy.nvim
-- This checks if "lazy.nvim" exists. If not, it clones it from GitHub.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath) -- Add lazy to the runtime path

-- LEADER KEYS
-- Must be set BEFORE loading lazy so plugins pick up the correct leader.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- This tells lazy to look at your "lua/plugins/" directory and load files there.
    { import = "plugins" },
  },
  -- Automatically check for plugin updates
  checker = { enabled = true },
})
