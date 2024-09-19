local cfg = require("yaml-companion").setup({
    -- Built in file matchers
    builtin_matchers = {
        -- Detects Kubernetes files based on content
        kubernetes = { enabled = true },
        cloud_init = { enabled = true }
    },

    -- Additional schemas available in Telescope picker
    schemas = {
        -- {
        --     name = "Kubernetes 1.22.4",
        --     uri =
        --     "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone-strict/all.json",
        -- },
    },

    -- Pass any additional options that will be merged in the final LSP config
    lspconfig = {
        flags = {
            debounce_text_changes = 150,
        },
        settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
                validate = true,
                format = {
                    enable = true,
                    bracketSpacing = false,
                },
                editor = { tabSize = 2 },
                hover = true,
                schemaStore = {
                    enable = false,
                    url = "https://www.schemastore.org/api/json/catalog.json",
                },
                schemaDownload = { enable = true },
                schemas = {
                    ['https://json.schemastore.org/catalog-info.json'] = 'template.{yml,yaml}',
                    ["https://json.schemastore.org/github-workflow.json"] = "**/.github/workflows/*",
                    ["https://json.schemastore.org/github-action.json"] = "**/.github/action.{yml,yaml}",
                    ["https://json.schemastore.org/kustomization.json"] = "**/kustomization.{yml,yaml}",
                    -- ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] =
                    -- "**/*flow*.{yml,yaml}",
                    -- kubernetes = '/*.yaml',
                },
                trace = { server = "debug" },
            },
        },
    },
})

require("lspconfig").yamlls.setup(cfg)
