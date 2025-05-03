return {
	"ray-x/go.nvim",
	dependencies = { -- optional packages
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("go").setup({
			luasnip = true,
		})

		-- Add generate interface implementation
		vim.keymap.set("n", "<leader>Gi", function()
			vim.ui.input({ prompt = "Receiver and Interface (e.g., MyStruct io.Reader): " }, function(input)
				if input then
					vim.cmd("GoImpl " .. input)
				end
			end)
		end, { desc = "[G]o Implement [I]nterface" })

		-- Add tags
		vim.keymap.set("n", "<leader>Gt", function()
			vim.ui.input({ prompt = "Tag Type: " }, function(input)
				if input then
					vim.cmd("GoAddTag " .. input)
				end
			end)
		end, { desc = "[G]o Generate [T]ag" })
	end,
	keys = {
		{ "<leader>Gr", "<cmd>GoRmTag<cr>", desc = "[G]o [R]emove Tag" },
	},
	event = { "CmdlineEnter" },
	ft = { "go", "gomod" },
	build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
