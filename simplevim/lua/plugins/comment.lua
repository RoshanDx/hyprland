return {
	-- PERF: fully optimised
	-- HACK: hmmm, this looks a bit funky
	-- TODO: What else?
	-- NOTE: Adding a note
	-- FIX: Fix this
	-- WARNING: Something about to happen
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup({
				signs = false,
			})
			vim.keymap.set("n", "<leader>qt", "<cmd>TodoQuickFix<cr>", { desc = "[Q]uicklist [T]ODO" })
			vim.keymap.set("n", "]t", function()
				require("todo-comments").jump_next()
			end, { desc = "Next todo comment" })

			vim.keymap.set("n", "[t", function()
				require("todo-comments").jump_prev()
			end, { desc = "Previous todo comment" })
		end,
	},
}
