return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,        -- Load this plugin immediately (don't wait for an event)
    build = ":TSUpdate", -- Run this command after install to update parsers
    config = function()
      local treesitter = require("nvim-treesitter")

      -- List of languages you want syntax highlighting for
      local parsers = {
        'lua', 'vim', 'vimdoc', 'javascript', 'typescript', 'html', 'yaml', 'markdown', 'markdown_inline'
      }

      -- Attempt to run setup/install (Custom logic)
      if treesitter.setup then treesitter.setup() end
      if treesitter.install then
          treesitter.install(parsers)
      else
          -- Standard fallback: Ensure these parsers are installed automatically
          require("nvim-treesitter.configs").setup({ ensure_installed = parsers })
      end

      -- Create an automatic event listener (Autocommand)
      vim.api.nvim_create_autocmd('FileType', {
        pattern = parsers, -- Run this only when opening files matching your list above
        callback = function()
          vim.treesitter.start() -- Turn on syntax highlighting
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- Use Treesitter for smart indentation
        end,
      })
    end
  },
}
