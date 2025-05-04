return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			{ "fredrikaverpil/neotest-golang", version = "*" }, -- Installation
		},
		config = function()
			local neotest_golang_opts = {} -- Specify custom configuration
			require("neotest").setup({
				adapters = {
					require("neotest-golang")(neotest_golang_opts), -- Registration
				},
			})
		end,
		keys = {
			{
				"<leader>tt",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Run [T]est",
			},
			{
				"<leader>tT",
				function()
					require("neotest").run.run(vim.uv.cwd())
				end,
				desc = "Run All [T]est Files",
			},
			{
				"<leader>tn",
				function()
					require("neotest").run.run()
				end,
				desc = "Run [T]est [N]earest",
			},
			{
				"<leader>tl",
				function()
					require("neotest").run.run_last()
				end,
				desc = "Run [T]est [L]ast",
			},
			{
				"<leader>ts",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "[T]est Toggle [S]ummary",
			},
			{
				"<leader>to",
				function()
					require("neotest").output.open({ enter = true, auto_close = true })
				end,
				desc = "[T]est Show [O]utput",
			},
			{
				"<leader>tO",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "[T]est [T]oggle [O]utput Panel",
			},
			{
				"<leader>tS",
				function()
					require("neotest").run.stop()
				end,
				desc = "[T]est [S]top",
			},
			{
				"<leader>tw",
				function()
					require("neotest").watch.toggle(vim.fn.expand("%"))
				end,
				desc = "[T]oggle [W]atch",
			},
		},
	},
}
