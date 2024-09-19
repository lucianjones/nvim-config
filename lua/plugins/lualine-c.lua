return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    config = function()
        require('lualine').setup({
            options = {
                icons_enabled = true,
                theme = require("neofusion.lualine"),
                component_separators = { left = '|', right = '|' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = { 'neo-tree', 'alpha' },
                    winbar = {},
                },
                ignore_focus = { 'neo-tree' },
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { { 'filename', path = 1 } },
                lualine_x = {
                    'encoding',
                    'fileformat',
                    'filetype',
                    {
                        function()
                            local schema = require("yaml-companion").get_buf_schema(0)
                            if schema.result[1].name == "none" then
                                return ""
                            end
                            return schema.result[1].name
                        end,
                    }
                },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { { 'filename', path = 1 } },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        })
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons' }
}
