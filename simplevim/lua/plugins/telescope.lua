return {
	"nvim-telescope/telescope.nvim",
  lazy = true,
	dependencies = {
    {"nvim-lua/plenary.nvim", lazy = true},
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			"nvim-telescope/telescope-fzf-native.nvim",
      lazy = true,
			-- `build` is used to run some command when the plugin is installed/updated.
			-- This is only run then, not every time Neovim starts up.
			build = "make",

			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" , lazy = true},

		-- Useful for getting pretty icons, but requires a Nerd Font.
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font , lazy = true },
	},
  keys = {
	  { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = "[F]ind [F]iles"},
	  { '<leader>fb', '<cmd>Telescope buffers<cr>' , desc = "[F]ind [B]uffers"},
	  { '<leader>fr', '<cmd>Telescope resume<cr>', desc = "[F]ind [R]esume"},
	  { '<leader>f.', '<cmd>Telescope oldfiles<cr>', desc = '[F]ind Recent Files ("." for repeat)'},
	  { '<leader>fd', '<cmd>Telescope diagnostics<cr>' , desc = "[F]ind [D]iagnostics"},
	  { '<leader>fw', '<cmd>Telescope grep_string<cr>' , desc = "[F]ind Current [W]ord"},
	  { '<leader>fg', '<cmd>Telescope live_grep<cr>' , desc = "[F]ind By [G]rep"},
	  { '<leader>fh', '<cmd>Telescope help_tags<cr>' , desc = "[F]ind [H]elp"},
	  { '<leader>fk', '<cmd>Telescope keymaps<cr>' , desc = "[F]ind [K]eymaps"},
	  { '<leader>ft', '<cmd>Telescope builtin<cr>' , desc = "[F]ind [T]elescope Commands"},
	  { '<leader>fy', function() 
          local yanked = vim.fn.getreg('"') -- unnamed register
          local escaped = yanked:gsub("\n", " ") -- or use "\\n" if you want literal \n
          require("telescope.builtin").live_grep({ default_text = escaped })
    end , desc = "[F]ind [Y]anked Text"},
  },
	config = function()
		require("telescope").setup({
			defaults = require("telescope.themes").get_ivy({
				mappings = {
					i = {
						["<esc>"] = require("telescope.actions").close,
					},
				},
				layout_config = { height = 0.4 },
			}),
			extensions = {},
			pickers = {},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
	end,
}
