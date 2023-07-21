return {
    {
        'nvim-treesitter/nvim-treesitter',
        version = false,
        build = ':TSUpdate',
        cmd = { "TSUpdateSync" },
        event = { 'BufReadPost', 'BufNewFile' },
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = 'all',
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                playground = {
                    enable = true,
                }
            })
        end,
    },
    {
        'nvim-treesitter/playground',
        cmd = { 'TSPlaygroundToggle' },
    }
}
