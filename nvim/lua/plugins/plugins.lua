return {
  -- LSP Progress Notifications (fidget.nvim)
  {"j-hui/fidget.nvim"},

  -- Word & Reference Highlighting (vim-illuminate)
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure({
        delay = 200,
      })
    end,
  },

  -- Automatic Delimiter Pairing (autoclose.nvim)
  {
    "m4xshen/autoclose.nvim",
    config = function()
      require("autoclose").setup()
    end,
  },

  -- Color Scheme Configuration (onedarkpro.nvim)
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
    config = function()
      require("onedarkpro").setup({
        options = {
          transparency = true,
        },
      })
      vim.cmd("colorscheme onedark_dark")
    end,
  },

  -- Task & Comment Annotations (todo-comments.nvim)
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    config = function()
      require("todo-comments").setup({
        vim.keymap.set("n", "<leader>tq", vim.cmd.TodoQuickFix),
      })
    end,
  },

  -- Persistent Undo Tree (undotree)
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end,
  },

  -- Motion & Search Navigation (flash.nvim)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },

  -- In-Buffer Markdown Rendering (render-markdown.nvim)
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },

  -- Quick File Marking & Switching (Harpoon)
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    lazy = false,
    config = function()
      local harpoon = require('harpoon')
      harpoon:setup({})

      -- File Operations
      vim.keymap.set('n', '<M-a>', function() harpoon:list():add() end, { desc = 'Harpoon: Add current file' })
      vim.keymap.set('n', '<M-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon: List all Harpoon files' })
      vim.keymap.set('n', '<M-x>', function() harpoon:list():clear() end, { desc = 'Harpoon: Clear all Harpoon files' })

      -- File Selection
      vim.keymap.set('n', '<M-h>', function() harpoon:list():select(1) end, { desc = 'Harpoon: Select Harpoon file 1' })
      vim.keymap.set('n', '<M-j>', function() harpoon:list():select(2) end, { desc = 'Harpoon: Select Harpoon file 2' })
      vim.keymap.set('n', '<M-k>', function() harpoon:list():select(3) end, { desc = 'Harpoon: Select Harpoon file 3' })
      vim.keymap.set('n', '<M-l>', function() harpoon:list():select(4) end, { desc = 'Harpoon: Select Harpoon file 4' })
    end,
  },

  -- Code Commenting Mappings (Comment.nvim)
  {
      "numToStr/Comment.nvim",
      opts = {
              padding = true,
              sticky = true,
              toggler = {
                  line = "gcc",
                  block = "gbc",
              },
              opleader = {
                  line = "gc",
                  block = "gb",
              },
              extra = {
                  above = "gca",
                  below = "gcb",
                  eol = "gce",
              },
              mappings = {
                  basic = true,
                  extra = true,
              },
      },
  },

  -- Buffer-Based File System Editor (oil.nvim)
  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup({
            default_file_explorer = true,
            delete_to_trash = true,
            skip_confirm_for_simple_edits = true,
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name, _)
                    return name == ".git" or name == ".." or name == ".github" or name == ".vscode"
                end,
            },
        })
        vim.keymap.set("n", "<BS>", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
  },

  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
      },
    },
  },
}
