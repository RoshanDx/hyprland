return {
	"lewis6991/gitsigns.nvim",
	-- keys = {
	--   {'<leader>gr', '<cmd>Gitsigns reset_hunk<cr>', desc = "Git [R]eset Hunk" },
	--   {'<leader>gR', '<cmd>Gitsigns reset_buffer<cr>', desc = "Git [R]eset Buffer" }
	-- },
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
			map("n", "]c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gitsigns.nav_hunk("next")
				end
			end, { desc = "Jump to next git [c]hange" })

			map("n", "[c", function()
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
			map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "[G]it [R]eset Hunk" })
			map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "[G]it [S]tage Buffer" })
			map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Git [R]eset Buffer" })
			map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "[G]it [P]review Hunk" })
			map("n", "<leader>gd", gitsigns.diffthis, { desc = "[G]it [D]iff Against Index" })
			-- Toggles
			map("n", "<leader>gb", gitsigns.toggle_current_line_blame, { desc = "[G]it [B]lame Line" })
		end,
	},
}
