return {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('kanagawa').setup({
            compile = true,
            terminalColors = true,
            colors = {
                palette = {},
                theme = {
                    wave = {
                        ui = {
                            bg_gutter = 'none'
                        }
                    }
                },
            },
            theme = "wave",
        })
        vim.cmd([[
            colorscheme kanagawa
            hi FloatBorder guibg=none
            hi NormalFloat guibg=none
            hi FloatTitle guibg=none
            hi FloatShadow guibg=none
            hi FloatShadowThrough guibg=none
        ]])
    end
}
