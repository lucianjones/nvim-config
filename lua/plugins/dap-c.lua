return {
    'mfussenegger/nvim-dap',
    lazy = false,
    keys = {
        { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
        { "<leader>dc", function() require("dap").continue() end,          desc = "Continue" },
        { "<leader>di", function() require("dap").step_into() end,         desc = "Step Into" },
        { "<leader>dj", function() require("dap").down() end,              desc = "Down" },
        { "<leader>dk", function() require("dap").up() end,                desc = "Up" },
        { "<leader>dl", function() require("dap").run_last() end,          desc = "Run Last" },
        { "<leader>do", function() require("dap").step_out() end,          desc = "Step Out" },
        { "<leader>dO", function() require("dap").step_over() end,         desc = "Step Over" },
        { "<leader>dr", function() require("dap").repl.toggle() end,       desc = "Toggle REPL" },
        { "<leader>ds", function() require("dap").session() end,           desc = "Session" },
        { "<leader>dt", function() require("dap").terminate() end,         desc = "Terminate" },
        { "<leader>dw", function() require("dap.ui.widgets").hover() end,  desc = "Widgets" },
    },
    dependencies = {
        {
            'williamboman/mason.nvim',
            build = ':MasonUpdate',
        },
        { 'jay-babu/mason-nvim-dap.nvim' },
        { 'nvim-neotest/nvim-nio' },
        { 'rcarriga/nvim-dap-ui' },
    },
    config = function()
        require('mason').setup()
        require('mason-nvim-dap').setup({
            automatic_installation = true,
            ensure_installed = {
                'python',
                'cppdbg',
                'codelldb',
                'bash',
            },
            handlers = {
                function(config)
                    require('mason-nvim-dap').default_setup(config)
                end,
                codelldb = function(config)
                    config.adapters = {
                        type = 'server',
                        port = '${port}',
                        executable = {
                            command = vim.fn.exepath('codelldb'),
                            args = { '--port', '${port}' },
                        },
                    }
                    require('mason-nvim-dap').default_setup(config)
                end
            }
        })
        require("dapui").setup()
        local dap, dapui = require("dap"), require("dapui")

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        dap.configurations.c = {
            {
                name = '(gdb) Launch',
                type = 'codelldb',
                request = 'launch',
                program = function()
                    return vim.fn.input(
                        'Path to executable: ',
                        vim.fn.getcwd() .. '/',
                        'file'
                    )
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                runInTerminal = false,
            },
        }
        dap.configurations.rust = dap.configurations.c
    end

}
