return {
	"andythigpen/nvim-coverage",
	version = "*",
	config = function()
		require("coverage").setup({
			auto_reload = true,
		})
	end,
	keys = {
		{
			"<leader>tlc",
			function()
				require("coverage").load()
			end,
			desc = "[T]est [L]oad [C]overage",
		},
		{
			"<leader>tc",
			function()
				require("coverage").toggle()
			end,
			desc = "[T]est [C]overage",
		},
		{
			"<leader>ts",
			function()
				require("coverage").summary()
			end,
			desc = "[T]est [S]ummary",
		},
	},
}
