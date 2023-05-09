require('exile.plugins')
require('exile.general')
require('exile.feline')
require('exile.startify')

-- Open NERDTree after startify exits
vim.cmd([[autocmd BufLeave * if (winnr("$") == 1 && &filetype == "startify") | NERDTree | endif]])
-- Quit NERDTree if it's the only window opened
vim.cmd(
    [[autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif]])
-- Switch to insert mode when entering the editor window
vim.cmd([[autocmd WinEnter * if &filetype !=# 'nerdtree' | startinsert | endif]])
-- Leave insert mode when entering NERDTree window
vim.cmd([[autocmd BufEnter * if &filetype ==# 'nerdtree' | stopinsert | endif]])
