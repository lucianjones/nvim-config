require('lspconfig').pylance.setup({
    settings = {
        python = {
            analysis = {
                autoImportCompletions = true,
                autoImportUserSymbols = true,
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                typeCheckingMode = "strict",
                useLibraryCodeForTypes = true,
                inlayHints = {
                    variableTypes = true,
                    funtionReturnTypes = true,
                    callArguementNames = true,
                    pytestparameters = true,
                }
            }
        }
    }
})
