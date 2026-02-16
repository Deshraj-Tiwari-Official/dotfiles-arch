return {
    -- Completion framework
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",    -- LSP source for nvim-cmp
            "hrsh7th/cmp-buffer",      -- Buffer completions
            "hrsh7th/cmp-path",        -- File path completions
            "hrsh7th/cmp-cmdline",     -- Command line completions
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = {
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), -- Select next item
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), -- Select previous item
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Confirm completion
                    ["<C-e>"] = cmp.mapping.abort(), -- Cancel completion
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item() -- Select next completion
                        else
                            fallback() -- Fallback to default Tab behavior
                        end
                    end, { "i", "s", "c" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item() -- Select previous completion
                        else
                            fallback() -- Fallback to default Shift+Tab behavior
                        end
                    end, { "i", "s", "c" }),
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                }),
            })

            -- Setup command-line completion
            cmp.setup.cmdline('/', {
                sources = {
                    { name = 'buffer' }  -- Suggest from buffer in search mode
                }
            })

            cmp.setup.cmdline(':', {
                sources = cmp.config.sources({
                    { name = 'cmdline' },  -- Command line completion
                }, {
                    { name = 'path' },      -- Path completions
                })
            })
        end,
    },

    -- Supermaven for AI-assisted completions
    {
      "supermaven-inc/supermaven-nvim",
      config = function()
        require("supermaven-nvim").setup({
          keymaps = {
            accept_suggestion = "<C-a>",
            clear_suggestion = "<C-e>",
          }
        })
      end,
    },
}
