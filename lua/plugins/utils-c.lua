return {
    {
        'echasnovski/mini.comment',
        version = false,
        event = 'VeryLazy',
        opts = {
            options = {
                ignore_blank_line = true,
            },
        },
    },
    {
        'echasnovski/mini.pairs',
        version = false,
        event = 'VeryLazy',
        config = true,
    },
    {
        'echasnovski/mini.surround',
        version = false,
        event = 'VeryLazy',
        opts = {
            mappings = {
                delete = 'ds',
                replace = 'cs',
            },
            silent = true,
        },
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        lazy = false,
        config = true,
    },
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        init = function()
            vim.g.startuptime_tries = 10
        end,
    },
}
