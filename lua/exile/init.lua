-- Load Exile plugins
-- Needs to be loaded before anything else as this is general configuration.
require('exile.general')
-- Plugins must then be loaded
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

-- Map <F4> to open NERDTree
vim.api.nvim_set_keymap('n', '<F4>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

-- Autocommands for buffer behavior
vim.cmd([[
  autocmd BufEnter,WinEnter * if &filetype ==# 'nerdtree' | startinsert | else | stopinsert | endif
]])

-- Default settings
vim.cmd('autocmd VimEnter * StartifyStart')
