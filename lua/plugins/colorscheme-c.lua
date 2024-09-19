return {
    "diegoulloao/neofusion.nvim",
    priority = 1000,
    config = function()
        -- Default options:
        require("neofusion").setup({
            terminal_colors = true, -- add neovim terminal colors
            undercurl = true,
            underline = true,
            bold = true,
            italic = {
                strings = true,
                emphasis = true,
                comments = true,
                operators = false,
                folds = true,
            },
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            inverse = true, -- invert background for search, diffs, statuslines and errors
            palette_overrides = {},
            overrides = {},
            dim_inactive = false,
            transparent_mode = true,
        })

        vim.cmd([[
            set background=dark
            colorscheme neofusion
        ]])
    end
}
-- return {
--     'rebelot/kanagawa.nvim',
--     lazy = false,
--     priority = 1000,
--     config = function()
--         require('kanagawa').setup({
--             compile = true,
--             terminalColors = true,
--             colors = {
--                 palette = {},
--                 theme = {
--                     wave = {
--                         ui = {
--                             bg_gutter = 'none'
--                         }
--                     }
--                 },
--             },
--             theme = "wave",
--         })
--         vim.cmd([[
--             colorscheme kanagawa
--             hi FloatBorder guibg=none
--             hi NormalFloat guibg=none
--             hi FloatTitle guibg=none
--             hi FloatShadow guibg=none
--             hi FloatShadowThrough guibg=none
--             hi! link Constant Type
--             hi! link Boolean PreProc
--         ]])
--     end
-- }
