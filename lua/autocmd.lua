local api = vim.api

--- Remove all trailing whitespace on save
local TrimWhiteSpaceGrp = api.nvim_create_augroup("TrimWhiteSpaceGrp", { clear = true })

api.nvim_create_autocmd(
    "BufWritePre",
    { command = [[:%s/\s\+$//e]], group = TrimWhiteSpaceGrp }
)

-- don't auto comment new line
api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

-- show cursor line only in active window
local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })

api.nvim_create_autocmd(
    { "InsertLeave", "WinEnter" },
    { pattern = "*", command = "set cursorline", group = cursorGrp }
)
api.nvim_create_autocmd(
    { "InsertEnter", "WinLeave" },
    { pattern = "*", command = "set nocursorline", group = cursorGrp }
)

-- Enable spell checking for certain file types
api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    {
        pattern = { "*.txt", "*.md", "*.tex" },
        callback = function()
            vim.opt.spell = true
            vim.opt.spelllang = "en"
        end,
    }
)

api.nvim_create_autocmd(
    { "FileType" },
    {
        pattern = { "yaml", "javascript", "typescript" },
        command = "setlocal ts=2 sts=2 sw=2 expandtab"
    }
)
api.nvim_create_autocmd(
    { "BufNewFile", "BufRead" },
    {
        pattern = { "*/templates/*.yaml", "*/templates/*.tpl", "*.gotmpl", "helmfile*.yaml", "Chart.yaml" },
        command = "setlocal filetype=helm"
    }
)
-- api.nvim_create_autocmd(
--     { "FileType" },
--     {
--         pattern = { "helm" },
--         callback = function() vim.diagnostic.enable(false) end

--     }
-- )
