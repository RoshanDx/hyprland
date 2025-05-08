return {
	"andythigpen/nvim-coverage",
	version = "*",
	config = function()
		require("coverage").setup({
			auto_reload = true,
		})

		local coverage = require("coverage")
		require("which-key").add({
			{ "<leader>tc", group = "[T]est [C]overage" },
			{
				"<leader>tcl",
				function()
					coverage.load()
				end,
				desc = "[T]est [C]overage [L]oad",
			},
			{
				"<leader>tct",
				function()
					coverage.toggle()
				end,
				desc = "[T]est [C]overage [T]oggle",
			},
			{
				"<leader>tcs",
				function()
					coverage.summary()
				end,
				desc = "[T]est [C]overage [S]ummary",
			},
		})
	end,
}
