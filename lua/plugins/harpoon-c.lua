return {
    'ThePrimeagen/harpoon',
    keys = {
        { [[<leader>h]], function() require('telescope').extensions.harpoon.marks() end },
        { [[<leader>m]], function() require('harpoon.mark').toggle_file() end },
        { [[<leader>n]], function() require('harpoon.mark').clear_all() end },
        { [[<leader>1]], function() require('harpoon.ui').nav_file(1) end },
        { [[<leader>2]], function() require('harpoon.ui').nav_file(2) end },
        { [[<leader>3]], function() require('harpoon.ui').nav_file(3) end },
        { [[<leader>4]], function() require('harpoon.ui').nav_file(4) end },
        { [[<leader>5]], function() require('harpoon.ui').nav_file(5) end },
    },
    opts = {
        global_settings = {
            save_on_toggle = true,
        },
    },
    dependencies = { 'nvim-lua/plenary.nvim' },
}
