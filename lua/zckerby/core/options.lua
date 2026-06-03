--==================================================================================================
-- OPTIONS   (merged from your old options.lua + options2.lua)
--==================================================================================================

-- UI / lines -------------------------------------------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "150"
vim.opt.showmatch = true             -- highlight matching brackets
vim.opt.showmode = false             -- mode is shown in lualine instead
vim.opt.cmdheight = 1
vim.opt.pumheight = 10                -- popup menu height
vim.opt.pumblend = 10                 -- popup menu transparency
vim.opt.conceallevel = 0             -- show backticks etc. in markdown
vim.opt.fillchars = { eob = " " }    -- hide ~ on empty lines
vim.opt.termguicolors = true
vim.opt.guicursor = "n-v-c-i:block"
vim.opt.showtabline = 1              -- top bar only when 2+ tabs (no bufferline now)

-- wrapping / scrolling ---------------------------------------------------------------------------
vim.opt.wrap = false
vim.opt.linebreak = true             -- if wrap is ever on, don't split mid-word
vim.opt.breakindent = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
vim.opt.whichwrap = "bs<>[]hl"       -- which keys wrap to prev/next line

-- indentation ------------------------------------------------------------------------------------
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- search -----------------------------------------------------------------------------------------
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- splits -----------------------------------------------------------------------------------------
vim.opt.splitbelow = true
vim.opt.splitright = true            -- (was missing from options2 -- restored)

-- clipboard / editing ----------------------------------------------------------------------------
vim.opt.clipboard = "unnamedplus"    -- sync with the system clipboard (was missing from options2)
vim.opt.backspace = "indent,eol,start"
vim.opt.selection = "inclusive"
vim.opt.mouse = "a"
vim.opt.iskeyword:append("-")        -- treat hyphenated words as one word
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- don't auto-continue comment leaders

-- files / persistence ----------------------------------------------------------------------------
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true              -- persistent undo across sessions
vim.opt.autoread = true
vim.opt.autowrite = false
vim.opt.hidden = true
vim.opt.autochdir = false
vim.opt.encoding = "UTF-8"
vim.opt.fileencoding = "utf-8"

-- completion / timing ----------------------------------------------------------------------------
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 0

-- wildmenu / misc perf ---------------------------------------------------------------------------
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.synmaxcol = 300              -- syntax highlight column limit
vim.opt.errorbells = false
vim.opt.diffopt:append("linematch:60")
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- keep Vim's runtime out of the way if Vim is also installed
pcall(function() vim.opt.runtimepath:remove("/usr/share/vim/vimfiles") end)

-- NOTE: dropped `lazyredraw` -- it causes redraw glitches with treesitter / async UIs and
-- modern Neovim doesn't need it. Add it back here if you specifically want it.
