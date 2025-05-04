return {
	{
		"sindrets/diffview.nvim",
		config = function()
			local function diffOpenWithInput()
				local user_input = vim.fn.input("Revision to Open: ")
				if user_input == nil or user_input == "" then
					-- User cancelled (pressed Esc or entered nothing), do nothing
					return
				end
				vim.cmd("DiffviewOpen " .. user_input)
			end

			local function diffOpenFileHistory()
				local user_input = vim.fn.input("Files to Open: ")
				if user_input == nil or user_input == "" then
					-- User cancelled (pressed Esc or entered nothing), do nothing
					return
				end
				vim.cmd("DiffviewFileHistory " .. user_input)
			end

			vim.keymap.set("n", "<leader>gc", "<cmd>DiffviewOpen<cr>", { desc = "[G]it [C]urrent" })
			vim.keymap.set("n", "<leader>gf", diffOpenFileHistory, { desc = "[G]it [F]iles" })
			vim.keymap.set("n", "<leader>gv", diffOpenWithInput, { desc = "[G]it Re[V]ision" })
			vim.keymap.set("n", "<leader>gq", "<cmd>DiffviewClose<cr>", { desc = "[G]it [Q]uit" })
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			preview_config = {
				border = "rounded",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]g", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { desc = "Jump to next git [c]hange" })

				map("n", "[g", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, { desc = "Jump to previous git [c]hange" })

				-- Actions
				-- visual mode
				map("v", "<leader>gs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "[G]it [S]tage Hunk" })
				map("v", "<leader>gr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "[G]it [R]eset Hunk" })
				-- normal mode
				map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "[G]it [S]tage Hunk" })
				map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "[G]it [R]eset Hunk" })
				map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "[G]it [S]tage Buffer" })
				map("n", "<leader>gu", gitsigns.stage_hunk, { desc = "[G]it [U]ndo Stage Hunk" })
				map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Git [R]eset Buffer" })
				map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "[G]it [P]review Hunk" })
				map("n", "<leader>gb", gitsigns.blame_line, { desc = "[G]it [B]lame Line" })
				map("n", "<leader>gd", gitsigns.diffthis, { desc = "[G]it [D]iff Against Index" })
				map("n", "<leader>gD", function()
					gitsigns.diffthis("@")
				end, { desc = "[G]it [D]iff Against Last Commit" })
				-- Toggles
				map(
					"n",
					"<leader>gtb",
					gitsigns.toggle_current_line_blame,
					{ desc = "[G]it [T]oggle Show [B]lame Line" }
				)
				map("n", "<leader>gtD", gitsigns.preview_hunk_inline, { desc = "[G]it [T]oggle Show [D]eleted" })
			end,
		},
	},
}
