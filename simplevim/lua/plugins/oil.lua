return {
	"stevearc/oil.nvim",
	event = "VimEnter",
	opts = {},
	dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
	keys = {
		{ "<M-1>", "<cmd>:Oil<cr>", desc = "Oil" },
	},
	config = function()
		require("oil").setup({
			view_options = {
				show_hidden = true,
			},
			float = {
				max_width = 60,
			},
		})
	end,
}
