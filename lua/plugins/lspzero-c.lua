vim.diagnostic.config({
    virtual_text = {
        source = "always"
    },
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
            {
                'L3MON4D3/LuaSnip',
                dependencies = { "rafamadriz/friendly-snippets" }
            },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-buffer' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'onsails/lspkind.nvim' },
            { "roobert/tailwindcss-colorizer-cmp.nvim" },
            { url = "https://codeberg.org/FelipeLema/cmp-async-path" },
        },
        config = function()
            local cmp = require('cmp')
            local cmp_action = require('lsp-zero.cmp').action()
            local luasnip = require("luasnip")
            local lspkind = require("lspkind")
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                preselect = 'item',
                completion = {
                    completeopt = 'menu,menuone,noinsert',
                    autocomplete = false,
                },
                window = {
                    completion = {
                        border = "rounded",
                        winhighlight = "Normal:Normal,FloatBorder:Comment,CursorLine:CursorLineBG,Search:None",
                        side_padding = 0,
                        col_offset = -4,
                        completeopt = 'menu,menuone,noinsert',
                        autocomplete = false,
                    },
                    documentation = {
                        border = "rounded",
                        winhighlight = "Normal:Normal,FloatBorder:Comment,CursorLine:CursorLineBG,Search:None",
                    },
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                sources = {
                    { name = 'luasnip' },
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                    { name = 'buffer' },
                },
                sorting = {
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,

                        function(entry1, entry2)
                            local _, entry1_under = entry1.completion_item.label:find "^_+"
                            local _, entry2_under = entry2.completion_item.label:find "^_+"
                            entry1_under = entry1_under or 0
                            entry2_under = entry2_under or 0
                            if entry1_under > entry2_under then
                                return false
                            elseif entry1_under < entry2_under then
                                return true
                            end
                        end,

                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
                mapping = {
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp_action.tab_complete(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
                    -- ['<Tab>'] = cmp_action.luasnip_supertab(),
                    -- ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
                },
                formatting = {
                    expandable_indicator = true,
                    fields = { 'kind', 'abbr', 'menu' },
                    format = function(entry, item)
                        local fmt = lspkind.cmp_format({
                            mode = "symbol_text",
                            maxwidth = 50,
                            ellipsis_char = '...',
                            menu = ({
                                buffer = "Buffer",
                                nvim_lsp = "LSP",
                                luasnip = "LuaSnip",
                                nvim_lua = "Lua",
                            })
                        })(entry, item)

                        vim.opt.pumheight = 10

                        local cmp_kinds = {
                            Text = "",
                            Method = "",
                            Function = "",
                            Constructor = "",
                            Field = "",
                            Variable = "",
                            Class = "",
                            Interface = "",
                            Module = "",
                            Property = "",
                            Unit = "",
                            Value = "",
                            Enum = "",
                            Keyword = "",
                            Snippet = "",
                            Color = "",
                            File = "",
                            Reference = "",
                            Folder = "",
                            EnumMember = "",
                            Constant = "",
                            Struct = "",
                            Event = "",
                            Operator = "",
                            TypeParameter = "",
                        }

                        local strings = vim.split(fmt.kind, "%s", { trimempty = true })
                        local type = strings[2]

                        local lspserver_name = ""
                        if entry.source.name == 'nvim_lsp' then
                            lspserver_name = entry.source.source.client.name
                        end

                        local src = " [" .. ((lspserver_name or fmt.menu[entry.source.name]) .. "]")

                        fmt.kind = " " .. (cmp_kinds[type] or "")
                        fmt.kind = fmt.kind .. " "
                        fmt.menu = type ~= nil and "  " .. (strings[2] .. src) or ""

                        return fmt
                    end
                },
            })
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
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
                'basedpyright',
                'bashls',
                'clangd',
                'cssls',
                'dockerls',
                'gopls',
                'html',
                'helm_ls',
                'jsonls',
                'lua_ls',
                'rust_analyzer',
                'sqlls',
                'taplo',
                'terraformls',
                'ts_ls',
                'vimls',
                'yamlls',
                'zk',
            })

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
                    'ruff',
                    'prettier',
                    'tflint',
                },
                automatic_installation = true,
                handlers = {},
            })
        end
    },
}
