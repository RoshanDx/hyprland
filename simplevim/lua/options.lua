-- General
vim.opt.termguicolors = true -- Enable term GUI colors
vim.opt.fileencoding = "utf-8" -- Set file encoding to UTF-8
vim.opt.updatetime = 100 -- Set faster completion
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.undofile = true -- Enable persistent undo file
vim.opt.swapfile = false -- Disable swap file
vim.opt.showmode = false -- Dont show since its already in statusline
vim.opt.iskeyword:append("-") -- Treat words separated by - as one word
vim.opt.fillchars:append({ eob = " " }) -- Remove curly braces in line number
vim.o.showcmd = false -- Dont show commands in bottom right
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus" -- Enable copying to system clipboard
end)
vim.opt.confirm = true -- Raise dialog asking to save current file
vim.opt.cmdheight = 0 -- Hide command input/output
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Searching Behaviors
vim.opt.hlsearch = true -- Highlight all matches in search
vim.opt.ignorecase = true -- Ignore case in search
vim.opt.smartcase = true -- Match case if explicitly stated

-- Splits
vim.opt.splitbelow = true -- Force horizontal splits below current window
vim.opt.splitright = true -- Force vertical splits right of current window

-- Indentation
vim.opt.tabstop = 2 -- Number of spaces inserted for tab character
vim.opt.shiftwidth = 2 -- Number of spaces inserted for each indentation level
vim.opt.softtabstop = 2 -- Number of spaces inserted for tab character
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.smartindent = true -- Enable smart indentation
vim.opt.breakindent = true -- Enable line breaking indentation

-- Lines
vim.opt.number = true
vim.opt.relativenumber = true -- Display line number
vim.opt.wrap = false -- Display lines as single line
vim.opt.cursorline = true -- Highlight current line

-- Appearance
vim.opt.scrolloff = 10 -- Number of lines to keep above/below cursor
vim.opt.sidescrolloff = 10 -- Number of columns to keep to the left/right of cursor

-- Code Folding
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Misc
vim.g.markdown_recommended_style = 0 -- Fix markdown indentation settings
