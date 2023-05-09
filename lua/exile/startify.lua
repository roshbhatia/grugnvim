-- startify.lua
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
                    return { line = v, path = v }
                end,
                cmd_output
            )
        return files
    end
end

-- define startify lists
vim.g.startify_lists = {
    { type = CommandToStartifyTable('find ~/github/*/* -maxdepth 0 -type d'), header = { "         Repositoreis" } }

}

-- set startify options
vim.g.startify_session_autoload = 1

-- Open NERDTree when leaving Startify buffer
vim.cmd([[autocmd BufLeave * if (winnr("$") == 1 && &filetype == "startify") | NERDTree | endif]])
-- Quit Startify when a file is opened from NERDTree
vim.cmd(
    [[autocmd BufEnter * if (winnr("$") > 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif]])
