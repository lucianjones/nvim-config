local opt = vim.opt
local g = vim.g

-- set leader
g.mapleader = ' '

-- tabs
opt.tabstop = 4
opt.shiftwidth = 0
opt.expandtab = true
opt.smartindent = true

-- backup / undo / swap
opt.backup = true
opt.swapfile = true
opt.undofile = true

opt.backupdir = '/tmp//'
opt.directory = '/tmp//'
opt.undodir = '/tmp//'

-- line number
opt.number = true
opt.cursorline = true
opt.cursorlineopt = 'number'
opt.signcolumn = 'yes'
opt.mouse = 'a'
opt.fillchars = { eob = " " }

-- search
opt.ignorecase = true
opt.smartcase = true
opt.shortmess:append('c')

-- misc
opt.updatetime = 300
opt.termguicolors = true
opt.clipboard = 'unnamedplus'
opt.hidden = true


vim.o.termguicolors = true
g.python_host_prog = '/Users/lucian.jones/venvs/.nvim-venv/bin/python'
g.python3_host_prog = '/Users/lucian.jones/venvs/.nvim-venv/bin/python'
