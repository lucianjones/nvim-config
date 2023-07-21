return {
    'SmiteshP/nvim-navic',
    lazy = false,
    config = function()
        require('nvim-navic').setup({
            lsp = {
                auto_attach = true,
            }
        })
    end
}
