--==================================================================================================
-- JAVA   (nvim-jdtls -- replaces the plain lspconfig jdtls setup)
--   jdtls, java-debug-adapter and java-test are installed by mason (see lsp.lua).
--   Generic LSP keymaps still come from the LspAttach autocmd in lsp.lua.
--==================================================================================================

vim.pack.add({ "https://github.com/mfussenegger/nvim-jdtls" })

local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"

-- Extra jars loaded into jdtls: the debug adapter + the test runner.
local function bundles()
	local jars = vim.fn.glob(
		mason_packages .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
		true,
		true
	)
	for _, jar in ipairs(vim.fn.glob(mason_packages .. "/java-test/extension/server/*.jar", true, true)) do
		local name = vim.fn.fnamemodify(jar, ":t")
		-- these two are not jdtls plugins and break startup if bundled
		if name ~= "com.microsoft.java.test.runner-jar-with-dependencies.jar" and name ~= "jacocoagent.jar" then
			table.insert(jars, jar)
		end
	end
	return jars
end

local function map(bufnr, mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
end

local function start_jdtls()
	local jdtls = require("jdtls")

	local root_dir = vim.fs.root(0, {
		"gradlew",
		"mvnw",
		"pom.xml",
		"build.gradle",
		"build.gradle.kts",
		"settings.gradle",
		"settings.gradle.kts",
		".git",
	}) or vim.fn.expand("%:p:h")

	-- one jdtls workspace (index/cache) per project; hash avoids clashes between same-named folders
	local workspace = vim.fn.stdpath("data")
		.. "/jdtls-workspace/"
		.. vim.fn.fnamemodify(root_dir, ":t")
		.. "-"
		.. vim.fn.sha256(root_dir):sub(1, 8)

	local extendedClientCapabilities = jdtls.extendedClientCapabilities
	extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

	jdtls.start_or_attach({
		cmd = { "jdtls", "-data", workspace },
		root_dir = root_dir,
		capabilities = require("blink.cmp").get_lsp_capabilities(),
		init_options = {
			bundles = bundles(),
			extendedClientCapabilities = extendedClientCapabilities,
		},
		settings = {
			java = {
				signatureHelp = { enabled = true },
				contentProvider = { preferred = "fernflower" }, -- decompile library classes on gd
				completion = {
					favoriteStaticMembers = {
						"org.junit.jupiter.api.Assertions.*",
						"org.junit.Assert.*",
						"org.mockito.Mockito.*",
						"org.hamcrest.Matchers.*",
					},
				},
				sources = {
					organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 },
				},
				inlayHints = { parameterNames = { enabled = "literals" } },
			},
		},
		on_attach = function(_, bufnr)
			-- F5 then offers every main class in the project as a launch target
			jdtls.setup_dap({ hotcodereplace = "auto" })

			-- refactors (normal: word under cursor, visual: selection)
			map(bufnr, "n", "<leader>jv", jdtls.extract_variable, "Java: extract variable")
			map(bufnr, "v", "<leader>jv", function()
				jdtls.extract_variable(true)
			end, "Java: extract variable")
			map(bufnr, "n", "<leader>jc", jdtls.extract_constant, "Java: extract constant")
			map(bufnr, "v", "<leader>jc", function()
				jdtls.extract_constant(true)
			end, "Java: extract constant")
			map(bufnr, "v", "<leader>jm", function()
				jdtls.extract_method(true)
			end, "Java: extract method")

			-- tests (run under the debugger, so breakpoints work)
			map(bufnr, "n", "<leader>jt", jdtls.test_nearest_method, "Java: test nearest method")
			map(bufnr, "n", "<leader>jT", jdtls.test_class, "Java: test class")

			map(bufnr, "n", "<leader>ju", "<cmd>JdtUpdateConfig<CR>", "Java: reload project config")
		end,
	})
end

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("zckerby_jdtls", { clear = true }),
	pattern = "java",
	callback = start_jdtls,
})
