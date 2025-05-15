return {
	"mistweaverco/kulala.nvim",
	ft = { "http", "rest" },
	config = function()
		require("kulala").setup({
			global_keymaps = true,
			ui = {
				default_view = "body",
			},
		})
		vim.opt.number = true
		vim.opt.relativenumber = true -- Display line number
		vim.opt.wrap = false -- Display lines as single line
		vim.opt.cursorline = true -- Highlight current line
		vim.keymap.set("n", "<A-7>", function()
			require("kulala").open()
		end, { desc = "Rest Toggle UI" })
	end,
}
