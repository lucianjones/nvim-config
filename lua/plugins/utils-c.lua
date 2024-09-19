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
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        init = function()
            vim.g.startuptime_tries = 10
        end,
    },
    {
        'echasnovski/mini.indentscope',
        version = false,
        lazy = false,
        config = function()
            require("mini.indentscope").setup({
                options = {
                    indent_at_cursor = true,
                    try_as_border = true,
                }
            })
        end,
    }
}
