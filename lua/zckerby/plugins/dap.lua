--==================================================================================================
-- DEBUGGING   (nvim-dap + nvim-dap-ui)
--   Language adapters are wired up elsewhere (e.g. java.lua registers the Java adapter via jdtls).
--==================================================================================================

vim.pack.add({
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/rcarriga/nvim-dap-ui",
})

local dap = require("dap")
local dapui = require("dapui")

dapui.setup()

-- open the UI when a session starts, close it when the session ends
dap.listeners.after.event_initialized["zckerby_dapui"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["zckerby_dapui"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["zckerby_dapui"] = function()
	dapui.close()
end

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "Visual" })

-- F-keys so nothing collides with the <leader>d diagnostic maps
local function map(lhs, rhs, desc)
	vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true, desc = desc })
end
map("<F5>", dap.continue, "Debug: start / continue")
map("<S-F5>", dap.terminate, "Debug: stop")
map("<F9>", dap.toggle_breakpoint, "Debug: toggle breakpoint")
map("<S-F9>", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, "Debug: conditional breakpoint")
map("<F10>", dap.step_over, "Debug: step over")
map("<F11>", dap.step_into, "Debug: step into")
map("<F12>", dap.step_out, "Debug: step out")
map("<F8>", dapui.toggle, "Debug: toggle UI")
