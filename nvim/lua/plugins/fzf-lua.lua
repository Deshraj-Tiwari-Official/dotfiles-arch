return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local fzflua = require("fzf-lua")
        local map = vim.keymap.set

        -- Base profile setup (clean titles, responsive floating preview window)
        fzflua.setup({
            "default-title",
            winopts = {
                height = 0.85,
                width = 0.85,
                row = 0.35,
                col = 0.50,
                border = "rounded",
                preview = {
                    border = "rounded",
                    layout = "flex",
                    flip_columns = 120,
                    scrollbar = "float",
                },
            },
            keymap = {
                builtin = {
                    -- Scroll preview inside fzf window
                    ["<C-d>"] = "preview-page-down",
                    ["<C-u>"] = "preview-page-up",
                },
                fzf = {
                    -- Toggle preview window visibility on the fly
                    ["ctrl-/"] = "toggle-preview",
                },
            },
            fzf_opts = {
                ["--info"] = "inline-right",
                ["--layout"] = "reverse",
            },
            files = {
                prompt = "Files❯ ",
                multiprocess = true,
                find_opts = [[-type f -not -path '*/.*']],
                rg_opts = [[--color=never --files --hidden --follow -g "!.git"]],
            },
            grep = {
                prompt = "Live Grep❯ ",
                multiprocess = true,
                rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --hidden -g '!.git'",
            },
            buffers = {
                prompt = "Buffers❯ ",
                sort_lastused = true,
                show_unloaded = true,
                cwd_only = false,
                actions = {
                    -- Close buffer directly from picker without opening it
                    ["ctrl-x"] = { fn = fzflua.actions.buf_del, reload = true },
                },
            },
            lsp = {
                async_or_timeout = 5000,
                symbols = {
                    symbol_style = 1,
                },
            },
        })

        -- Keybindings (Structured & Memorable)

        -- Find / Files (<leader>f...)
        map("n", "<leader>pf", function() fzflua.files() end, { desc = "Find files" })
        map("n", "<leader>pb", function() fzflua.buffers() end, { desc = "Switch open buffers" })
        map("n", "<leader>pR", function() fzflua.resume() end, { desc = "Resume last fzf search" })

        -- Search / Grep (<leader>s...)
        map("n", "<leader>sg", function() fzflua.live_grep() end, { desc = "Live grep (project)" })
        map("n", "<leader>sw", function() fzflua.grep_cword() end, { desc = "Search word under cursor" })
        map("v", "<leader>sw", function() fzflua.grep_visual() end, { desc = "Search selection" })
        map("n", "<leader>sb", function() fzflua.lgrep_curbuf() end, { desc = "Live grep current buffer" })

        -- LSP & Diagnostics (<leader>l...)
        map("n", "<leader>ld", function() fzflua.lsp_definitions() end, { desc = "LSP definitions" })
        map("n", "<leader>lr", function() fzflua.lsp_references() end, { desc = "LSP references" })
        map("n", "<leader>li", function() fzflua.lsp_implementations() end, { desc = "LSP implementations" })
        map("n", "<leader>ls", function() fzflua.lsp_document_symbols() end, { desc = "Document symbols" })
        map("n", "<leader>lS", function() fzflua.lsp_workspace_symbols() end, { desc = "Workspace symbols" })
        map("n", "<leader>xx", function() fzflua.diagnostics_workspace() end, { desc = "Workspace diagnostics" })
        map("n", "<leader>xb", function() fzflua.diagnostics_document() end, { desc = "Buffer diagnostics" })

        -- Git (<leader>g...)
        map("n", "<leader>gs", function() fzflua.git_status() end, { desc = "Git status" })
        map("n", "<leader>gc", function() fzflua.git_commits() end, { desc = "Git commits" })
        map("n", "<leader>gb", function() fzflua.git_branches() end, { desc = "Git branches" })
        map("n", "<leader>gf", function() fzflua.git_files() end, { desc = "Git files" })
    end,
}
