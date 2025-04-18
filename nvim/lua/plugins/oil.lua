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

		local keymap = vim.keymap
		local opts = { noremap = true, silent = true }

		keymap.set("n", "<leader>fe", ":Oil<CR>", opts)
	end,
}
