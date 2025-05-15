return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"igorlfs/nvim-dap-view",
			opts = {
				winbar = {
					sections = { "console", "watches", "scopes", "exceptions", "breakpoints", "threads", "repl" },
				},
				windows = {
					terminal = {
						position = "left",
						-- List of debug adapters for which the terminal should be ALWAYS hidden
						hide = {},
						-- Hide the terminal when starting a new session
						start_hidden = true,
					},
				},
			},
		},
		"leoluz/nvim-dap-go",
		-- "rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		-- DAP
		local dap = require("dap")

		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "[D]ebug [B]reakpoint" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "[D]ebug [C]ontinue" })
		vim.keymap.set("n", "<leader>di", dap.step_over, { desc = "[D]ebug Step [I]nto" })
		vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "[D]ebug Step [O]ver" })
		vim.keymap.set("n", "<leader>dO", dap.step_over, { desc = "[D]ebug Step [O]ut" })
		vim.keymap.set("n", "<leader>dB", function()
			vim.ui.input({ prompt = "Breakpoint Condition: " }, function(input)
				if input then
					dap.set_breakpoint(input)
				end
			end)
		end, { desc = "[D]ebug: Set [B]reakpoint" })

		-- Colorscheme
		vim.api.nvim_set_hl(0, "DapStopped", {
			fg = "#E5E9F0", -- white text
			bg = "#A3BE8C", -- green background
			bold = true,
		})

		vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "", linehl = "", numhl = "DapBreakpoint" })
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = "◆", texthl = "", linehl = "", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define(
			"DapBreakpointRejected",
			{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define(
			"DapLogPoint",
			{ text = "✎", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
		)
		vim.fn.sign_define("DapStopped", { text = "▶", texthl = "", linehl = "DapStopped", numhl = "" })

		-- DAP View
		local dv = require("dap-view")
		dap.listeners.before.attach["dap-view-config"] = function()
			dv.open()
		end
		dap.listeners.before.launch["dap-view-config"] = function()
			dv.open()
		end
		dap.listeners.before.event_terminated["dap-view-config"] = function()
			dv.close()
		end
		dap.listeners.before.event_exited["dap-view-config"] = function()
			dv.close()
		end

		vim.keymap.set("n", "<leader>du", dv.toggle, { desc = "[D]ebug [U]I" })

		-- DAP Virtual Text
		require("nvim-dap-virtual-text").setup()

		-- GO
		require("dap-go").setup()
		local dap_go = require("dap-go")

		require("which-key").add({
			{ "<leader>Gd", group = "[G]o [D]ebug" },
			{
				"<leader>Gdt",
				function()
					dap_go.debug_test()
				end,
				desc = "[G]o [D]ebug [T]est",
			},
			{
				"<leader>Gdl",
				function()
					dap_go.debug_last_test()
				end,
				desc = "[G]o [D]ebug [L]ast Test",
			},
		})
	end,
}
