-- /home/vscode/.config/nvim/init.lua
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim
require("lazy").setup({
  spec = {
    -- LazyVim core plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- TypeScript support
    {
      "pmizio/typescript-tools.nvim",
      dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
      opts = {},
    },

    -- Python support
    {
      "neovim/nvim-lspconfig",
      config = function()
        local lspconfig = require("lspconfig")
        lspconfig.pyright.setup({})
      end,
    },

    -- Additional useful plugins
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  performance = {
    rtp = {
      disabled_plugins = { "tohtml", "tutor", "zipPlugin" },
    },
  },
})

-- Basic Neovim settings
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true

-- Configure Treesitter for better syntax highlighting
require("nvim-treesitter.configs").setup({
  ensure_installed = { "typescript", "javascript", "python" },
  highlight = { enable = true },
  indent = { enable = true },
})

