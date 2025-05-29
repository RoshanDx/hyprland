
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" , lazy = true},
	config = function()
		require("lualine").setup({
			options = {
				theme = "nord",
				icons_enabled = true,
				component_separators = "|",
				section_separators = "",
			},
			sections = {
				lualine_a = {
					{
						"buffers",
					},
				},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {
					"diagnostics",
					"diff",
					"branch",
				},
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
