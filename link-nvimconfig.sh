#!/bin/bash

# Set the source directory where your Neovim configuration files are located
src="$(pwd)"

# Set the destination directory for Neovim configuration files in your home directory
dst="$HOME/.config/nvim"

# Check if the destination directory already exists
if [ -e "$dst" ]; then
    echo "WARNING: $dst already exists. Do you want to overwrite it? (y/n)"
    read answer
    if [ "$answer" != "y" ]; then
        echo "Aborted."
        exit 1
    fi
    # Remove the existing directory before creating a new one
    rm -rf "$dst"
fi

# Create a symbolic link to the source directory
ln -s "$src" "$dst"
echo "Linked $src to $dst."

# Create a separate directory for kubectl.nvim config
kvdst="$HOME/.config/kv"
mkdir -p "$kvdst"

# Create init.lua for kubectl.nvim
cat > "$kvdst/init.lua" <<EOL
-- Initialize kubectl.nvim config
vim.cmd('set nocompatible')
vim.opt.viminfo:remove({'!'})

-- Init lazy plugin manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable',
                   lazypath})
end
vim.opt.rtp:prepend(lazypath)

-- Install only necessary plugins for kubectl
require('lazy').setup({
    -- Core essentials
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'kepano/flexoki-neovim',
    'bluz71/nvim-linefly',
    -- Kubectl integration
    'Ramilito/kubectl.nvim',
    -- Helpful utilities
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {'nvim-lua/plenary.nvim'}
    },
    {
        'akinsho/toggleterm.nvim',
        version = '*',
        config = true
    }
}, {
    lazy = false,
    version = false
})

-- Basic settings
vim.opt.termguicolors = true
vim.cmd('colorscheme flexoki-dark')
vim.wo.number = true
vim.o.mouse = 'a'

-- Kubectl setup with expanded capabilities
require('kubectl').setup({
    -- Configure kubectl settings here
    -- These are examples - adjust to your needs
    kubernetes_resources = {
        "pods",
        "deployments",
        "services",
        "configmaps",
        "secrets",
        "ingresses",
        "namespaces",
        "statefulsets",
        "daemonsets",
        "persistentvolumes",
        "persistentvolumeclaims",
    },
    terminal_width_percentage = 0.8,
    kubectl_terminal_height_ratio = 0.9, 
    logs_formatter = "DLOG", -- or "auto"
    logs_timestamp = true,
    logs_format = "wide",  -- can be "default" or "wide"
})

-- Keybindings specific to kubectl
vim.g.mapleader = ' '

-- Kubectl main commands
vim.api.nvim_set_keymap('n', '<leader>kp', ':lua require("kubectl").get_pods()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>kd', ':lua require("kubectl").get_deployments()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ks', ':lua require("kubectl").get_services()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ki', ':lua require("kubectl").get_ingresses()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>kc', ':lua require("kubectl").get_configmaps()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>kn', ':lua require("kubectl").get_namespaces()<CR>', { noremap = true, silent = true })

-- Kubectl actions
vim.api.nvim_set_keymap('n', '<leader>kl', ':lua require("kubectl").get_logs()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>kf', ':lua require("kubectl").port_forward()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ke', ':lua require("kubectl").exec()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>kk', ':lua require("kubectl").describe()<CR>', { noremap = true, silent = true })

-- Telescope integration
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })

-- Terminal
vim.api.nvim_set_keymap('n', '<C-\\\\>', ':ToggleTerm<CR>', { noremap = true, silent = true })
EOL

echo "Created kubectl.nvim config at $kvdst"

# Create a shell script for 'kv' command
mkdir -p "$HOME/bin"
cat > "$HOME/bin/kv" <<EOL
#!/bin/bash

# Start neovim with kubectl.nvim config
XDG_CONFIG_HOME=~/.config NVIM_APPNAME=kv nvim "\$@"
EOL

# Make the script executable
chmod +x "$HOME/bin/kv"

echo "Created 'kv' command in ~/bin"
echo "Make sure ~/bin is in your PATH or move the script to a directory in your PATH"
