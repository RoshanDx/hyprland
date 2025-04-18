return {
	"sindrets/diffview.nvim",
	config = function()
		local keymaps = vim.keymap

		keymaps.set("n", "<leader>gdf", "<cmd>DiffviewFileHistory<cr>", { desc = "Repo history" })
	end,
}
