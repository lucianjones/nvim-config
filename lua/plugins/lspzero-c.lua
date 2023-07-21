vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    float = {
        format = function(diagnostic)
            return string.format(
                "%s [%s]",
                diagnostic.message,
                diagnostic.source
            )
        end,
    },
})
return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        config = function()
            require('lsp-zero.settings').preset({
                float_border = 'rounded',
                configure_diagnostics = true,
                setup_servers_on_start = true,
                manage_nvim_cmp = false,
            })
        end
    },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            { 'L3MON4D3/LuaSnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-buffer' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'onsails/lspkind.nvim' },
        },
        config = function()
            local cmp = require('cmp')
            local cmp_action = require('lsp-zero.cmp').action()
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                preselect = 'item',
                completion = {
                    completeopt = 'menu,menuone,noinsert',
                    autocomplete = false,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                    { name = 'buffer' },
                    { name = 'luasnip' },
                },
                mapping = {
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp_action.luasnip_supertab(),
                    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
                },
                formatting = {
                    format = require('lspkind').cmp_format({
                        mode = "symbol_text",
                        menu = ({
                            buffer = "Buffer",
                            nvim_lsp = "LSP",
                            luasnip = "LuaSnip",
                            nvim_lua = "Lua",
                        })
                    }),
                },
            })
        end
    },
    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        event = { 'BufReadPost', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            {
                "folke/neodev.nvim"
                ,
                opts = {}
            },
            { 'jose-elias-alvarez/null-ls.nvim' },
            { 'jay-babu/mason-null-ls.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            {
                'williamboman/mason.nvim',
                build = ":MasonUpdate",
            },
        },
        config = function()
            local lsp = require('lsp-zero')

            lsp.on_attach(
                function(_, bufnr)
                    lsp.default_keymaps({
                        buffer = bufnr,
                        omit = { '<F2>', '<F3>', '<F4>' },
                    })
                    lsp.buffer_autoformat()
                    lsp.set_sign_icons({
                        error = '✘',
                        warn = '▲',
                        hint = '~',
                        info = '»'
                    })

                    local map = vim.keymap.set
                    local opts = { buffer = true }
                    map('n', 'gR', function() vim.lsp.buf.rename() end, opts)
                    map('n', 'gf', function() vim.lsp.buf.format({ async = true }) end, opts)
                    map('n', 'ga', function() vim.lsp.buf.code_action() end, opts)
                end
            )

            lsp.set_server_config({
                on_init = function(client)
                    client.server_capabilities.semanticTokensProvider = nil
                end,
            })

            lsp.ensure_installed({
                'arduino_language_server',
                'bashls',
                'clangd',
                'cssls',
                'dockerls',
                'gopls',
                'html',
                'helm_ls',
                'jsonls',
                'tsserver',
                'lua_ls',
                -- 'pyright',
                'rust_analyzer',
                'sqlls',
                'taplo',
                'terraformls',
                'vimls',
                'yamlls',
                'zk',
            })

            -- lsp.setup_servers({ 'pylance' })
            require('lsp-configs')
            require("neodev").setup({})

            lsp.setup()

            local nullls = require('null-ls')
            nullls.setup({ sources = {} })
            nullls.register({
                name = 'generate docstring',
                method = { nullls.methods.CODE_ACTION },
                filetypes = { '_all' },
                generator = {
                    fn = function()
                        return { {
                            title = 'generate docstring',
                            action = function()
                                require('neogen').generate({})
                            end
                        } }
                    end
                }
            })

            require('mason-null-ls').setup({
                ensure_installed = {
                    'black',
                    'flake8',
                    'isort',
                    'prettier',
                    'tflint',
                },
                automatic_installation = false,
                handlers = {},
            })
        end
    },
}
