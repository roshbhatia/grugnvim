-- Init lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system(
        {"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
         lazypath})
end
vim.opt.rtp:prepend(lazypath)

-- Install external plugins
require("lazy").setup({'preservim/nerdtree', 'jackguo380/vim-lsp-cxx-highlight', 'liuchengxu/vim-which-key',
                       'feline-nvim/feline.nvim', 'nyoom-engineering/oxocarbon.nvim', 'mhinz/vim-startify'}, {
    lazy = false,
    version = false
})

-- Load Exile plugins
local exile_modules = {
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
