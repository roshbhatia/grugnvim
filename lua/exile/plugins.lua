-- Install plugin manager
vim.cmd('packadd packer.nvim')

-- Start plugin management with packer
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'preservim/nerdtree'
  use 'jackguo380/vim-lsp-cxx-highlight'
  use 'liuchengxu/vim-which-key'
  use 'feline-nvim/feline.nvim'
  use "savq/melange-nvim"
  use 'mhinz/vim-startify'
end)
