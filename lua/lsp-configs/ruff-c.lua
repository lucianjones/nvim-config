local lspconfig = require('lspconfig')

lspconfig.ruff.setup({
    trace = 'messages',
    init_options = {
        settings = {
            configurationPreference = "filesystemFirst",
            exclude = {
                ".bzr",
                ".direnv",
                ".eggs",
                ".git",
                ".git-rewrite",
                ".hg",
                ".ipynb_checkpoints",
                ".mypy_cache",
                ".nox",
                ".pants.d",
                ".pyenv",
                ".pytest_cache",
                ".pytype",
                ".ruff_cache",
                ".svn",
                ".tox",
                ".venv",
                ".vscode",
                "__pypackages__",
                "_build",
                "buck-out",
                "build",
                "dist",
                "node_modules",
                "site-packages",
                "venv",
            },
            logLevel = 'info',
            lineLength = 100,
            fixAll = true,
            organizeImports = true,
            showSyntaxErrors = true,
            codeAction = {
                disableRuleComment = { enable = true },
                fixViolation = { enable = true }
            },
            lint = {
                enable = true,
                preview = true,
                select = { 'E', 'F' },
            },
            format = { preview = true }
        }
    }
})
