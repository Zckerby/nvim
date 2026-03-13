--==================================================================================================
--OPTIONS
--==================================================================================================
vim.opt.number = true --line numbers on 
vim.opt.relativenumber = true --relative line numbers
vim.opt.cursorline = true -- highlight the current line
vim.opt.wrap = false --wrap lines not default
vim.opt.scrolloff = 10 --keep 10 lines above/below the cursor
vim.opt.sidescrolloff = 10 --keep 10 lines left/right of the cursor

vim.opt.tabstop = 2 --tabwidth
vim.opt.shiftwidth = 2 --indent width
vim.opt.softtabstop = 2 -- soft tab stop not tabs on tab/backspace
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smartindent = true -- smart auto indent
vim.opt.autoindent = true -- copy indent from current line

vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- case sensitife if uppercase in string
vim.opt.hlsearch = true -- highlight search matches
vim.opt.incsearch = true -- show matches as you type

vim.opt.signcolumn = "yes" -- always show a sign column
vim.opt.colorcolumn = "150" -- show a column at 100 postion chars
vim.opt.showmatch = true -- highlights matching brackets
vim.opt.cmdheight = 1 -- single line command line
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.showmode = false -- do not show the mode instead have it in status line
vim.opt.pumheight = 10 -- popup menu height
vim.opt.pumblend = 10 -- popup menu transparency
vim.opt.lazyredraw = true -- do not redraw during macros
vim.opt.synmaxcol = 300 -- syntax highlighting limit
vim.opt.fillchars = {eob = " " } -- hide "~" on empty lines

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = false
vim.opt.updatetime = 300 -- faster completion
vim.opt.timeoutlen = 500 --timeout duration
vim.opt.ttimeoutlen = 0 -- key code timeout
vim.opt.autoread = true -- autor-reload changes if outside of neovim
vim.opt.autowrite = false -- do not auto-save

vim.opt.hidden = true -- allow hidden buffers
vim.opt.errorbells = false -- no error sounds
vim.o.backspace = 'indent,eol,start'
vim.opt.autochdir = false -- do not autochange directories
vim.opt.iskeyword:append("-") --  include - in words
vim.opt.selection = "inclusive" -- include last char in selection
vim.opt.mouse = "a" -- enable mouse support
vim.opt.modifiable = true -- allow buffer modifcations
vim.opt.encoding = "UTF-8" -- set encoding

vim.opt.guicursor = 'n-v-c-i:block'            


vim.o.splitbelow = true -- Force all horizontal splits to go below current window (default: false)
vim.o.splitbelow = true -- Force all horizontal splits to go below current window (default: false)

vim.opt.wildmenu = true --tab completion
vim.opt.wildmode = "longest:full,full" -- complete longest common match, fullcompletion list, cycle through with Tab
vim.opt.diffopt:append("linematch:60") -- improve diff display
vim.opt.redrawtime = 10000 -- increase neovim redraw tolerance
vim.opt.maxmempattern = 20000 -- increase max memory
