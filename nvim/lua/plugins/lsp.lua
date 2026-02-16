return {
  -- 1. Mason - To install LSP servers
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- 2. Mason LSP Config
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "clangd",
        },
      })
    end,
  },

  -- 3. LSP Config - To configure and enable LSP servers
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      if vim.lsp.config then
          vim.lsp.config('lua_ls', { capabilities = capabilities })
          vim.lsp.config('clangd', { capabilities = capabilities })
          vim.lsp.enable('lua_ls')
          vim.lsp.enable('clangd')
      else
          local lspconfig = require('lspconfig')
          lspconfig.lua_ls.setup({ capabilities = capabilities })
          lspconfig.clangd.setup({ capabilities = capabilities })
      end

      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Docs" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format File" })
    end,
  },

  -- 4. None-ls - Formatting
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.clang_format,
        },
      })
    end,
  },
}
