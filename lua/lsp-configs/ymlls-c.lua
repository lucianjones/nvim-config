local cfg = require("yaml-companion").setup({
    -- Built in file matchers
    builtin_matchers = {
        -- Detects Kubernetes files based on content
        kubernetes = { enabled = true },
        cloud_init = { enabled = true }
    },

    -- Additional schemas available in Telescope picker
    schemas = {
        {
            name = "Kubernetes 1.22.4",
            uri =
            "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone-strict/all.json",
        },
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
                format = { enable = true },
                hover = true,
                schemaStore = {
                    enable = true,
                    url = "https://www.schemastore.org/api/json/catalog.json",
                },
                schemaDownload = { enable = true },
                schemas = {
                    ['https://json.schemastore.org/catalog-info.json'] = 'template.{yml,yaml}',
                    ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                    ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                    ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
                    ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
                },

                trace = { server = "debug" },
            },
        },
    },
})

require("lspconfig").yamlls.setup(cfg)
