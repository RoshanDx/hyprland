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
			"<leader>tcl",
			function()
				require("coverage").load()
			end,
			desc = "[T]est [C]overage [L]oad",
		},
		{
			"<leader>tct",
			function()
				require("coverage").toggle()
			end,
			desc = "[T]est [C]overage [T]oggle",
		},
		{
			"<leader>tcs",
			function()
				require("coverage").summary()
			end,
			desc = "[T]est [C]overage [S]ummary",
		},
	},
}
