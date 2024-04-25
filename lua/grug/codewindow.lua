-- Check if code preview should be enabled
if vim.g.code_preview_enabled == nil then
    vim.g.code_preview_enabled = true  -- default to true
end

require('codewindow').setup({
    auto_enable = function()
        return vim.g.code_preview_enabled
    end
})

-- Apply default keybinds conditionally
if vim.g.code_preview_enabled then
    require('codewindow').apply_default_keybinds()
end

