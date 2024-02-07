return {
    'stevearc/dressing.nvim',
    opts = {
        select = {
            backend = { "nui" },
            nui = {
                -- position = "50%",
                position = {
                    row = 2,
                    col = 0,
                },
                -- size = nil,
                relative = "cursor",
                border = {
                    style = "rounded",
                },
                buf_options = {
                    swapfile = false,
                    filetype = "DressingSelect",
                },
                win_options = {
                    winblend = 10,
                    winhighlight = "Normal:Normal",
                },
                max_width = nil,
                max_height = nil,
                min_width = 1,
                min_height = 1,
            },
        },
    },
    lazy = false,
}
