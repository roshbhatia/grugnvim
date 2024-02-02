local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
end

-- Load Exile plugins
local exile_modules = {
  'plugins',
  'general',
  'feline',
  'nerdtree',
  'startify',
}

for _, module in ipairs(exile_modules) do
  require('grug.' .. module)
end

-- Define a custom command to open Startify
vim.cmd([[
  command! StartifyStart call StartifyStart()
  function! StartifyStart()
    Startify
  endfunction
]])

-- Map <F1> to open or close Startify
vim.api.nvim_set_keymap('n', '<F1>', ':StartifyStart<CR>', { noremap = true, silent = true })

-- Map <C-Space> to open or close NERDTree
vim.api.nvim_set_keymap('n', '<C-Space>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

-- Autocommands for buffer behavior
vim.cmd([[
  autocmd BufEnter,WinEnter * if &filetype ==# 'nerdtree' | startinsert | else | stopinsert | endif
]])

-- Default settings
vim.cmd('autocmd VimEnter * StartifyStart')
