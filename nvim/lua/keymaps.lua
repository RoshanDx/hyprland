local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap.set("n", ";p", '"0P', opts) -- Paste last yanked

keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Shift visual selected line down
keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- Shift visual selected line up

-- Panes
keymap.set("n", "<c-h>", "<c-w>h", opts)
keymap.set("n", "<c-j>", "<c-w>j", opts)
keymap.set("n", "<c-k>", "<c-w>k", opts)
keymap.set("n", "<c-l>", "<c-w>l", opts)

-- Windows
keymap.set("n", "<leader>v", ":vsplit<CR>", opts)
keymap.set("n", "<leader>h", ":split<CR>", opts)

-- Buffers
keymap.set("n", "<tab>", ":bnext<CR>", opts)
keymap.set("n", "<s-tab>", ":bprev<CR>", opts)
keymap.set("n", "<leader>q", ":bdelete!<CR>", opts)

-- Vertical split resize
keymap.set("n", "<C-Left>", ":vertical resize +3<CR>")
keymap.set("n", "<C-Right>", ":vertical resize -3<CR>")

-- Continuing indentation
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Terminal
keymap.set("n", "<leader>t", ":botright 8split | terminal<CR>", opts)
keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Highlight
keymap.set("n", "<esc>", ":set hlsearch!<CR>") -- Toggle search highlight
