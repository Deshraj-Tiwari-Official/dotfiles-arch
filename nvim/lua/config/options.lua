-- UI Feedback & Syntax Highlighting Autocommands 
vim.api.nvim_set_hl(0, 'YankHighlight', { bg = '#B3BF93', fg = '#f8f8f2' })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = 'YankHighlight'})
  end,
})

-- Visual Mode Colors: Custom background color for selected text. 
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.api.nvim_set_hl(0, 'Visual', { bg = '#5c6370' })
  end,
})

-- General Formatting & Mouse Behavior 
local opt = vim.opt

-- Formatting & Mouse 
vim.g.autoformat = true
vim.o.mouse = ""          -- Disable mouse (keyboard only warrior mode) 
vim.o.hlsearch = false    -- Don't keep search results highlighted after Enter 

-- Visual Appearance & Interface 
-- Appearance 
opt.guicursor = ""        -- cursor style 
opt.termguicolors = true  -- Enable 24-bit RGB color 
opt.signcolumn = "yes"    -- Always show the sign column (prevents text shifting) 
opt.cursorline = true     -- Highlight the line the cursor is on 
opt.number = true         -- Show line numbers 
opt.relativenumber = true -- Show relative line numbers (great for jumps) 
opt.wrap = false          -- Disable line wrapping 
opt.laststatus = 0        -- Disable status line 
opt.showtabline = 2       -- Always show tabs 

-- Tabs & Indentation 
opt.expandtab = true      -- Convert tabs to spaces 
opt.tabstop = 2           -- Insert 2 spaces for a tab 
opt.softtabstop = 2 
opt.shiftwidth = 2        -- Number of spaces for auto-indent 
opt.smartindent = true 

-- Search & Viewport Scrolling 
opt.incsearch = true      -- Show search matches as you type 
opt.ignorecase = true     -- Ignore case when searching... 
opt.smartcase = true      -- ...unless you type a capital letter 
opt.scrolloff = 8         -- Keep 8 lines of context above/below cursor 

-- System, Backups & Undo History 
opt.swapfile = false      -- Don't create swap files 
opt.backup = false        -- Don't create backup files 
opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Persistent undo history location 
opt.undofile = true       -- Enable persistent undo 
opt.updatetime = 100      -- Faster completion/update time 
opt.timeoutlen = 1000     -- Time to wait for a mapped sequence to complete 
