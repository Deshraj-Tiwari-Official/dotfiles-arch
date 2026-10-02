 -- Leader Keys Setup
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Command Mode Shortcuts
map("n", ";", ":")

-- Clipboard & Register Management
map({"n", "v"}, "<leader>y", [["+y]]) -- Copy to system clipboard
map({"n", "v"}, "<leader>p", [["+p]]) -- Paste from system clipboard
map("x", "<A-p>", [["_dP]])           -- Paste over selection without losing copied text

-- Text Movement & Line Editing
-- Move selected lines up/down (Magic Primeagen move)
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Join lines but keep cursor in place
map("n", "J", "mzJ`z")

-- Centered Navigation & Search
-- Scroll half page and keep cursor centered
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")

-- Search next/prev and keep cursor centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Search & Replace Utilities
-- Replace the word you are currently hovering over
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Quickfix List Navigation
map("n", "<A-k>", "<cmd>cnext<CR>zz")
map("n", "<A-j>", "<cmd>cprev<CR>zz")

-- Window Resizing
map("n", "<C-Up>", "<cmd>resize -2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize +2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize +2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize -2<cr>", { desc = "Increase Window Width" })

-- Buffer Navigation
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<S-x>", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })

-- Indentation Controls
-- Allows you to indent multiple times without losing selection
map("v", "<", "<gv")
map("v", ">", ">gv") 
