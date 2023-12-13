-- Load Exile plugins
require('exile.general')
require('exile.plugins')
require('exile.feline')
require('exile.startify-nerdtree')

-- Define a custom command to open Startify
vim.cmd([[
  command! StartifyStart call StartifyStart()
  function! StartifyStart()
    Startify
  endfunction
]])

-- Keybinding to open Startify
vim.api.nvim_set_keymap('n', '<F3>', ':StartifyStart<CR>', { noremap = true, silent = true })

-- Define a custom command to open NERDTree on the left
vim.cmd([[
  command! NERDTreeOpen :NERDTreeToggle<CR>
]])

-- Map <F4> to open NERDTree
vim.api.nvim_set_keymap('n', '<F4>', ':NERDTreeOpen<CR>', { noremap = true, silent = true })

-- Autocommands for buffer behavior
vim.cmd([[
  autocmd BufEnter,WinEnter * if &filetype ==# 'nerdtree' | startinsert | else | stopinsert | endif
]])

-- Default settings
vim.cmd('autocmd VimEnter * StartifyStart')
