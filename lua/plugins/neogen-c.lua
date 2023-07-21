return {
    "danymat/neogen",
    cmd = { 'Neogen' },
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
        snippet_engine = "luasnip",
        languages = {
            python = {
                template = {
                    annotation_convention = 'numpydoc'
                }
            }
        }
    },
    version = "*"
}
