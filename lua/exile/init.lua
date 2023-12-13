-- Load Exile plugins
require('exile.plugins')
require('exile.general')
require('exile.feline')

-- Import your Startify configuration
require('exile.startify')

-- Define a custom command to open Startify
vim.cmd([[
  command! StartifyStart call StartifyStart()
  function! StartifyStart()
    Startify
  endfunction
]])

-- Autocommands for buffer behavior
vim.cmd([[
  autocmd WinEnter * if &filetype !=# 'nerdtree' | startinsert | endif
  autocmd BufEnter * if &filetype ==# 'nerdtree' | stopinsert | endif
  autocmd BufEnter * if &filetype == 'startify' | stopinsert | endif
]])

-- Keybinding to open Startify
vim.api.nvim_set_keymap('n', '<F3>', ':StartifyStart<CR>', { noremap = true, silent = true })

-- Default settings
vim.cmd('autocmd VimEnter * StartifyStart')
