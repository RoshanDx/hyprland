return {
	-- 	{
	-- 		"rjshkhr/shadow.nvim",
	-- 		priority = 1000,
	-- 		config = function()
	-- 			vim.opt.termguicolors = true
	-- 			vim.cmd.colorscheme("shadow")
	-- 		end,
	-- 	},
	{
		"shaunsingh/nord.nvim",
		priority = 1000,
		config = function()
			vim.g.nord_contrast = true
			vim.g.nord_borders = false
			vim.g.nord_disable_background = false
			vim.g.nord_italic = false
			vim.g.nord_uniform_diff_background = true
			vim.g.nord_bold = true
			vim.cmd.colorscheme("nord")
		end,
	},
}
