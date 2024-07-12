-- Init lazy plugin manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        'git', 'clone', '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- Install external plugins
require('lazy').setup({
    {'kepano/flexoki-neovim', name = 'flexoki'}, 'lewis6991/gitsigns.nvim',
    'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons', {
        'nvim-tree/nvim-tree.lua',
        version = '*',
        lazy = false,
        after = {'nvim-tree/nvim-web-devicons'},
        dependencies = {'nvim-tree/nvim-web-devicons'},
        config = function() require('nvim-tree').setup {} end
    }, {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim', 'nvim-tree/nvim-web-devicons'
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {}
    }, 'jackguo380/vim-lsp-cxx-highlight', 'liuchengxu/vim-which-key',
    'tamton-aquib/staline.nvim', 'mhinz/vim-startify',
    'gorbit99/codewindow.nvim',
    'gelguy/wilder.nvim'
}, {lazy = false, version = false})

-- Load Exile plugins
local exile_modules = {
    'general', 'barline', 'staline', 'startify', 'nvim-tree', 'codewindow', 'wilder'
}

for _, module in ipairs(exile_modules) do require('grug.' .. module) end

-- Define a custom command to open Startify
vim.cmd([[
  command! StartifyStart call StartifyStart()
  function StartifyStart()
    execute 'Startify'
  endfunction
]])

-- Keybindings
-- Map <F1> to open or close Startify
vim.api.nvim_set_keymap('n', '<F1>', ':StartifyStart<CR>',
                        {noremap = true, silent = true})

-- Map <F2> to open or close nvim-tree
vim.api.nvim_set_keymap('n', '<F2>', ':NvimTreeToggle<CR>',
                        {noremap = true, silent = true})

-- Default settings

if vim.v.argv == 0 then
    vim.cmd('autocmd VimEnter * StartifyStart')
end
