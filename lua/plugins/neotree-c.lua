return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    keys = {
        { [[<leader>e]], '<cmd>Neotree focus filesystem toggle reveal<CR>', 'n', silent = true }
    },
    opts = {
        sources = {
            "filesystem",
            "buffers",
            "git_status",
            "document_symbols",
        },
        add_blank_line_at_top = false,
        close_if_last_window = true,
        default_component_configs = {
            git_status = {
                symbols = {
                    added     = '✚',
                    modified  = '',
                    deleted   = '✖',
                    renamed   = '󰁕',
                    untracked = '?',
                    ignored   = '',
                    unstaged  = '󰄱',
                    staged    = '',
                    conflict  = '',
                }
            },
            diagnostics = {
                symbols = {
                    hint = "H",
                    info = "I",
                    warn = "!",
                    error = "X",
                },
                highlights = {
                    hint = "DiagnosticSignHint",
                    info = "DiagnosticSignInfo",
                    warn = "DiagnosticSignWarn",
                    error = "DiagnosticSignError",
                },
            },
        },
        popup_border_style = 'rounded',
        window = {
            width = 45,
            popup = {
                position = { col = "100%", row = "2" },
                size = function(state)
                    local root_name = vim.fn.fnamemodify(state.path, ":~")
                    local root_len = string.len(root_name) + 4
                    return {
                        width = math.max(root_len, 45),
                        height = vim.o.lines - 6
                    }
                end,
            },
            mapping_options = {
                noremap = true,
                nowait = true,
            },
            mappings = {
                -- ['<cr>'] = 'open_with_window_picker',
                ['<TAB>'] = 'next_source',
                ['<S-TAB>'] = 'prev_source',
                ["h"] = function(state)
                    local node = state.tree:get_node()
                    if node.type == 'directory' and node:is_expanded() then
                        require('neo-tree.sources.filesystem').toggle_directory(state, node)
                    else
                        require('neo-tree.ui.renderer').focus_node(state, node:get_parent_id())
                    end
                end,
                ["l"] = function(state)
                    local node = state.tree:get_node()
                    if node.type == 'directory' then
                        if not node:is_expanded() then
                            require('neo-tree.sources.filesystem').toggle_directory(state, node)
                        elseif node:has_children() then
                            require('neo-tree.ui.renderer').focus_node(state, node:get_child_ids()[1])
                        end
                    elseif node.type == 'file' then
                        require('neo-tree.sources.filesystem.commands').open(state)
                    end
                end,
            },
        },
        filesystem = {
            use_libuv_file_watcher = true,
            filtered_items = {
                visible = false,
                hide_dotfiles = false,
                hide_gitignored = false,
                hide_by_name = { 'node_modules' },
                never_show = { '.DS_Store' },
            },
            components = {
                harpoon_index = function(config, node, _)
                    local Marked = require("harpoon.mark")
                    local path = node:get_id()
                    local succuss, index = pcall(Marked.get_index_of, path)
                    if succuss and index and index > 0 then
                        return {
                            text = string.format("%d 󰛢", index), -- <-- Add your favorite harpoon like arrow here ⇟󰛢
                            highlight = config.highlight or "NeoTreeDirectoryIcon",
                        }
                    else
                        return {}
                    end
                end
            },
            renderers = {
                file = {
                    { "indent" },
                    { "icon" },
                    {
                        "container",
                        content = {
                            {
                                "name",
                                zindex = 10
                            },
                            { "harpoon_index", zindex = 10 },
                            { "clipboard",     zindex = 10 },
                            { "bufnr",         zindex = 10 },
                            { "modified",      zindex = 20, align = "right" },
                            { "diagnostics",   zindex = 20, align = "right" },
                            { "git_status",    zindex = 20, align = "right" },
                        },
                    },
                },
            },
        },
        source_selector = {
            winbar = true,
            sources = {
                { source = 'filesystem' },
                { source = 'buffers' },
                { source = 'git_status' },
                { source = 'document_symbols' },
            },
            content_layout = 'center',
            tabs_layout = 'end',
            truncation_character = "",
        },
        event_handlers = {
            { -- close file explorer on file selection
                event = "file_opened",
                handler = function(_)
                    require("neo-tree.command").execute({ action = "close" })
                end
            },
        },
    },
    config = function(_, opts)
        require('neo-tree').setup(opts)

        vim.cmd [[
            hi FloatBorder guibg=none
            hi NormalFloat guibg=none
            hi NeoTreeFloatTitle guibg=none
            hi NeoTreeTabInactive guibg=none
        ]]
    end,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        {
            's1n7ax/nvim-window-picker',
            version = 'v2.*',
            opts = {
                highlights = {
                    statusline = {
                        focused = {
                            fg = '#ededed',
                            bg = '#658594',
                            bold = true,
                        },
                        unfocused = {
                            fg = '#ededed',
                            bg = '#658594',
                            bold = true,
                        },
                    },
                },
                show_prompt = false,
                filter_rules = {
                    autoselect_one = true,
                }
            },
        },
    },
}
