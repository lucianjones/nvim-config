local map = vim.keymap.set

-- Switch splits
map('n', '<C-h>', '<C-w>h', { desc = 'Move left' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move down' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move up' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move right' })

-- Clear search
map('n', '<leader>c', '<cmd>nohlsearch<CR>')
