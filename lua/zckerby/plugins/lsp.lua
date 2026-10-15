--==================================================================================================
-- LSP   (mason + nvim-lspconfig + native vim.lsp)
--==================================================================================================

vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

require("mason").setup()

-- Make sure .astro files are recognized as filetype "astro" -- without this neither the
-- LSP nor treesitter attaches (Neovim core doesn't map the .astro extension by default).
vim.filetype.add({ extension = { astro = "astro" } })

--==================================================================================================
-- Diagnostics UI
--==================================================================================================
local signs = { Error = " ", Warn = " ", Hint = "", Info = "" }
vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 4 },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = signs.Error,
			[vim.diagnostic.severity.WARN] = signs.Warn,
			[vim.diagnostic.severity.INFO] = signs.Info,
			[vim.diagnostic.severity.HINT] = signs.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = true, header = "", prefix = "" },
})

-- rounded borders on hover / signature popups
do
	local orig = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, o, ...)
		o = o or {}
		o.border = o.border or "rounded"
		return orig(contents, syntax, o, ...)
	end
end

--==================================================================================================
-- Buffer-local keymaps on LSP attach
--   (Diagnostic keymaps live in core/keymaps.lua so they work without an LSP too.)
--==================================================================================================
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("zckerby_lsp_attach", { clear = true }),
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if not client then
			return
		end
		local bufnr = ev.buf
		local builtin = require("telescope.builtin")
		local function map(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
		end

		map("K", vim.lsp.buf.hover, "Hover docs")
		map("gd", builtin.lsp_definitions, "Go to definition")
		map("gr", builtin.lsp_references, "Find references")
		map("gD", vim.lsp.buf.declaration, "Go to declaration")
		map("<leader>gS", function()
			vim.cmd("vsplit")
			vim.lsp.buf.definition()
		end, "Definition in split")
		map("<leader>ca", vim.lsp.buf.code_action, "Code action")
		map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")

		if client:supports_method("textDocument/codeAction") then
			map("<leader>oi", function()
				vim.lsp.buf.code_action({
					context = { only = { "source.organizeImports" }, diagnostics = {} },
					apply = true,
				})
				vim.defer_fn(function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end, 50)
			end, "Organize imports + format")
		end
	end,
})

--==================================================================================================
-- Server configs  (capabilities come from blink, applied to every server via "*")
--==================================================================================================
local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
		},
	},
})

vim.lsp.config("cssls", {
	settings = {
		css = { validate = true },
		scss = { validate = true },
		less = { validate = true },
	},
})

vim.lsp.config("tailwindcss", {
	-- extend so Tailwind triggers across your whole frontend stack
	filetypes = {
		"html",
		"css",
		"scss",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"astro",
		"svelte",
		"vue",
	},
})

vim.lsp.config("emmet_language_server", {
	filetypes = {
		"html",
		"css",
		"scss",
		"javascriptreact",
		"typescriptreact",
		"astro",
		"vue",
		"svelte",
	},
})

-- Generic clangd. Picks up flags from each project's compile_commands.json
-- (PlatformIO: `pio run -t compiledb`; CMake: -DCMAKE_EXPORT_COMPILE_COMMANDS=ON).
-- --query-driver lets clangd ask these cross-compilers for their real system
-- include paths, instead of guessing with the host compiler and flooding you
-- with false "file not found" / builtin-type errors on embedded projects.
vim.lsp.config("clangd", {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=never",
		"--completion-style=detailed",
		"--query-driver=/home/zckerby/.platformio/packages/toolchain-gccarmnoneeabi-teensy/bin/*,/usr/bin/arm-none-eabi-*,/home/zckerby/.platformio/packages/toolchain-xtensa*/bin/*",
	},
	filetypes = { "c", "cpp", "objc", "objcpp" },
	root_markers = { "compile_commands.json", ".clangd", "CMakeLists.txt", ".git" },
})

-- defaults are fine for these
vim.lsp.config("html", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("astro", {})
vim.lsp.config("pyright", {})
vim.lsp.config("bashls", {})

--==================================================================================================
-- mason: install servers + dev tools, then enable the servers
--==================================================================================================
local servers = {
	"lua_ls",
	"clangd",
	"ts_ls",
	"astro",
	"tailwindcss",
	"html",
	"emmet_language_server",
	"cssls",
	"jdtls",
	"pyright",
	"bashls",
	-- "cmake" removed: cmake-language-server is a pip package and failed to install.
	-- clangd covers your C/C++. To add it later (needs Python+pip):
	--   :MasonInstall cmake-language-server   then add "cmake" back here.
}

require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_enable = false, -- we enable explicitly below, after configs are defined
})

-- formatters + linters used by format.lua (this is what efm used to depend on, now auto-installed)
require("mason-tool-installer").setup({
	ensure_installed = {
		"stylua",
		"prettierd",
		"eslint_d",
		"clang-format",
		"shfmt",
		"shellcheck",
		"java-debug-adapter", -- jdtls bundles, loaded by java.lua
		"java-test",
	},
})

-- jdtls is installed above but started by nvim-jdtls (java.lua), not here
vim.lsp.enable(vim.tbl_filter(function(s)
	return s ~= "jdtls"
end, servers))
