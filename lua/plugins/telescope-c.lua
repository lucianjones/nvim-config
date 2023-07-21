local map = vim.keymap.set
return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    cmd = { 'Telescope' },
    keys = {
        { [[<leader>']],  function() require('telescope.builtin').find_files() end },
        { [[<leader>;]],  function() require('telescope.builtin').live_grep() end },
        { [[<leader>fb]], function() require('telescope.builtin').buffers() end },
        { [[<leader>fh]], function() require('telescope.builtin').help_tags() end },
    },
    config = function()
        local telescope = require('telescope')
        local vimgrep_arguments = { unpack(require('telescope.config').values.vimgrep_arguments) }

        -- Search in hidden files, exclude .git dir
        table.insert(vimgrep_arguments, '--hidden')
        table.insert(vimgrep_arguments, '--glob')
        table.insert(vimgrep_arguments, '!**/.git/*')

        telescope.setup({
            defaults = {
                vimgrep_arguments = vimgrep_arguments,
                mappings = {
                    i = {
                        ['<C-h>'] = 'which_key',
                        ['<esc>'] = require('telescope.actions').close
                    }
                }
            },
            pickers = {
                find_files = {
                    find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
                    theme = 'ivy',
                },
                live_grep = {
                    theme = 'ivy',
                }
            },
            extensions = {}
        })

        telescope.load_extension('fzf')
        telescope.load_extension('yaml_schema')
        telescope.load_extension('harpoon')
    end,
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        { 'someone-stole-my-name/yaml-companion.nvim' },
    },
}
