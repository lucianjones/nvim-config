require('lspconfig').pyright.setup({
    single_file_support = true,
    settings = {
        pyright = {
            disableOrganizeImports = true
        },
        python = {
            autoImportCompletions = true,
            autoSearchPaths = true,
            diagnosticMode = "workspace",
            typeCheckingMode = "strict",
            useLibraryCodeForTypes = true
        }
    }
})
