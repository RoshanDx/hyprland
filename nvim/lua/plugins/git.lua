return {
	{
		"sindrets/diffview.nvim",
		config = function()
			local function diffOpenWithInput()
				local user_input = vim.fn.input("Revision to Open: ")
				if user_input == nil or user_input == "" then
					-- User cancelled (pressed Esc or entered nothing), do nothing
					return
				end
				vim.cmd("DiffviewOpen " .. user_input)
			end

			local function diffOpenFileHistory()
				local user_input = vim.fn.input("Files to Open: ")
				if user_input == nil or user_input == "" then
					-- User cancelled (pressed Esc or entered nothing), do nothing
					return
				end
				vim.cmd("DiffviewFileHistory " .. user_input)
			end

			vim.keymap.set("n", "<leader>gf", diffOpenFileHistory, { desc = "[G]it [F]iles" })
			vim.keymap.set("n", "<leader>gv", diffOpenWithInput, { desc = "[G]it Re[V]ision" })
			vim.keymap.set("n", "<leader>gq", "<cmd>DiffviewClose<cr>", { desc = "[G]it [Q]uit" })
			vim.keymap.set({ "n", "v" }, "<leader>gl", function()
				local mode = vim.fn.mode()
				if mode ~= "v" and mode ~= "V" then
					vim.cmd("normal! V") -- enter visual line mode
					vim.cmd("normal! gv") -- fix visual marks
				end
				vim.cmd("'<,'>DiffviewFileHistory")
			end, { desc = "[G]it [L]ines" })
		end,
	},
	{
		"echasnovski/mini.diff",
		event = "VeryLazy",
		keys = {
			{
				"<leader>go",
				function()
					require("mini.diff").toggle_overlay(0)
				end,
				desc = "[G]it Toggle [O]verlay",
			},
		},
		opts = {
			view = {
				style = "sign",
				signs = {
					add = "▎",
					change = "▎",
					delete = "",
				},
			},
		},
	},
}
