vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- MAPPING: Map ; to : so you don't have to press Shift for commands
map("n", ";", ":")

-- CLIPBOARD
map({"n", "v"}, "<leader>y", [["+y]]) -- Copy to system clipboard
map({"n", "v"}, "<leader>p", [["+p]]) -- Paste from system clipboard
map("x", "<A-p>", [["_dP]])           -- Paste over selection without losing copied text

-- MOVEMENT & EDITING
-- Move selected lines up/down (Magic Primeagen move)
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Join lines but keep cursor in place
map("n", "J", "mzJ`z")

-- Scroll half page and keep cursor centered
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")

-- Search next/prev and keep cursor centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- SEARCH & REPLACE
-- Replace the word you are currently hovering over
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- QUICKFIX NAVIGATION
map("n", "<A-k>", "<cmd>cnext<CR>zz")
map("n", "<A-j>", "<cmd>cprev<CR>zz")

-- WINDOW RESIZING
map("n", "<C-Up>", "<cmd>resize -2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize +2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize +2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize -2<cr>", { desc = "Increase Window Width" })

-- BUFFER NAVIGATION
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- INDENTATION (Visual Mode)
-- Allows you to indent multiple times without losing selection
map("v", "<", "<gv")
map("v", ">", ">gv")
