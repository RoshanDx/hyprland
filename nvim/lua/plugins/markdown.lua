return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		opts = {},
		config = function()
			require("render-markdown").setup({
				completions = {
					lsp = { enabled = true },
				},
				render_modes = { "n" },
				anti_conceal = {
					enabled = false,
					ignore = {
						check_icon = true,
						table_border = true,
					},
				},
				win_options = {
					concealcursor = { rendered = "nvic" },
				},
				checkbox = {
					custom = {
						important = {
							raw = "[~]",
							rendered = "󰓎 ",
							highlight = "DiagnosticWarn",
						},
						todo = { rendered = "◯ " },
					},
					unchecked = { icon = "✘ " },
					checked = { icon = "✔ " },
				},
			})
		end,
	},
}
