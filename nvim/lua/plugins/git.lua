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

			vim.keymap.set("n", "<leader>gc", "<cmd>DiffviewOpen<cr>", { desc = "[G]it [C]urrent" })
			vim.keymap.set("n", "<leader>gf", diffOpenFileHistory, { desc = "[G]it [F]iles" })
			vim.keymap.set("n", "<leader>gv", diffOpenWithInput, { desc = "[G]it Re[V]ision" })
			vim.keymap.set("n", "<leader>gq", "<cmd>DiffviewClose<cr>", { desc = "[G]it [Q]uit" })
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
}
