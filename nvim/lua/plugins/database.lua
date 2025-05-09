return {
	"kndndrj/nvim-dbee",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	build = function()
		-- Install tries to automatically detect the install method.
		-- if it fails, try calling it with one of these parameters:
		--    "curl", "wget", "bitsadmin", "go"
		-- NOTE: after load run `lua require("dbee").install()`
		require("dbee").install("go")
	end,
	config = function()
		require("dbee").setup({
			-- editor window config
			editor = {
				-- mappings for the buffer
				mappings = {
					-- run what's currently selected on the active connection
					{ key = "BB", mode = "v", action = "run_selection" },
					-- run the whole file on the active connection
					{ key = "BB", mode = "n", action = "run_file" },
				},
			},
		})

		local dbee = require("dbee")
		vim.keymap.set("n", "<leader>Du", function()
			dbee.toggle()
		end, { desc = "[D]atabase [U]I" })
	end,
}
