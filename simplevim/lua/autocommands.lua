vim.cmd([[au BufEnter * set fo-=c fo-=r fo-=o]]) -- Disable new line comments

-- highlight yanked text for 200ms using the "Visual" highlight group
vim.cmd([[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=300})
augroup END
]])

