vim.g.startify_custom_header = {
    '███████╗██╗  ██╗██╗██╗     ███████╗',
    '██╔════╝╚██╗██╔╝██║██║     ██╔════╝',
    '█████╗   ╚███╔╝ ██║██║     █████╗  ',
    '██╔══╝   ██╔██╗ ██║██║     ██╔══╝  ',
    '███████╗██╔╝ ██╗██║███████╗███████╗',
    '╚══════╝╚═╝  ╚═╝╚═╝╚══════╝╚══════╝',
}

function CommandToStartifyTable(command)
    return function()
        local cmd_output = vim.fn.systemlist(command .. " 2>/dev/null")
        local files =
            vim.tbl_map(
                function(v)
                    local path = string.gsub(v, os.getenv("HOME"), "~")
                    return { line = "  " .. path, path = v }
                end,
                cmd_output
            )
        return files
    end
end

vim.g.startify_lists = {
    { type = CommandToStartifyTable('find ~/github/*/* -maxdepth 0 -type d'), header = { "         Repositories" } }
}
vim.g.startify_session_autoload = 1

vim.cmd([[
    augroup startify_close
        autocmd!
        autocmd FileType startify nnoremap <buffer> <CR> :call StartifyOpenOrCloseNERDTree()<CR>
    augroup END
]])

function StartifyOpenOrCloseNERDTree()
    local is_open = vim.api.nvim_eval("exists('t:NERDTreeBufName')")
    if is_open == 0 then
        vim.api.nvim_command("NERDTree")
        vim.api.nvim_command("vertical resize 35")
        vim.cmd("startinsert")
    else
        vim.api.nvim_command("NERDTreeClose")
    end
end
