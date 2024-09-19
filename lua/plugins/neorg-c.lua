return {
    "nvim-neorg/neorg",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = "norg",
    opts = {
        load = {
            ["core.defaults"] = {},  -- Loads default behaviour
            ["core.concealer"] = {}, -- Adds pretty icons to your documents
            ["core.completion"] = {},
            ["core.dirman"] = {      -- Manages Neorg workspaces
                config = {
                    workspaces = {
                        notes = "~/.notes",
                    },
                },
            },
        },
    }
}
