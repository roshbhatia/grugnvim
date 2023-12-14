-- Set NERDTree options to always open on the left
vim.g.NERDTreeWinPos = "left"
vim.g.NERDTreeWinSize = 25

-- Supress edit errors
vim.g.NERDTreeBufHijack = 0

-- Map Shift+Enter to open file in a new tab in NERDTree
vim.api.nvim_set_keymap('n', '<S-Enter>', ':OpenTab %:p<CR>', { noremap = true, silent = true })

-- Map Shift+Tab+Enter to open file in a right split pane in NERDTree
vim.api.nvim_set_keymap('n', '<S-Tab><S-Enter>', ':OpenRightSplit %:p<CR>', { noremap = true, silent = true })
