return {
	"mfussenegger/nvim-dap",
	enabled = false,
	event = "VeryLazy",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"jay-babu/mason-nvim-dap.nvim",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local dap = require("dap")

		dap.configurations.java = {
			{
				type = "java",
				name = "Debug",
				request = "launch",
				program = "${file}",
			},
		}

		vim.fn.sign_define("DapBreakpoint", {
			text = "🔴",
			texthl = "DapBreakpointSymbol",
			linehl = "DapBreakpoint",
			numhl = "DapBreakpoint",
		})
		vim.fn.sign_define("DapStopped", {
			texthl = "DapStoppedSymbol",
			linehl = "CursorLine",
			numhl = "DapBreakpoint",
		})

		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
		vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
		vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })

		local dapui = require("dapui")
		dapui.setup()

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			--dapui.close()
		end

		vim.keymap.set("n", "<Leader>du", function()
			dapui.toggle()
		end)
	end,
}
