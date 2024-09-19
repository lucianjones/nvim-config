return {
    "OXY2DEV/markview.nvim",
    lazy = false,
    config = function()
        require("markview").setup({
            modes = { "n", "no", "c" }, -- Change these modes
            -- to what you need

            hybrid_modes = { "n" }, -- Uses this feature on
            -- normal mode
            tables = {
                enable = true,
                use_virt_lines = true,
            },

            -- This is nice to have
            callbacks = {
                on_enable = function(_, win)
                    vim.wo[win].conceallevel = 2;
                    vim.wo[win].concealcursor = "c";
                end
            }
        })
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    }
}
