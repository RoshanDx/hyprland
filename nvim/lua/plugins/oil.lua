return {
	"stevearc/oil.nvim",
	opts = {},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			view_options = {
				show_hidden = true,
			},
			float = {
				max_width = 60,
			},
		})

		vim.keymap.set("n", "<leader>_", ":Oil<CR>", { desc = "Oil" })
	end,
}
