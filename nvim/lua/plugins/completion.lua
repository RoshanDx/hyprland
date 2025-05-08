return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
		},
	},
	{
		"MattiasMTS/cmp-dbee",
		dependencies = {
			{ "kndndrj/nvim-dbee" },
		},
		ft = "sql", -- optional but good to have
		opts = {}, -- needed
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local luasnip = require("luasnip")

			require("luasnip.loaders.from_vscode").lazy_load()

			vim.opt.completeopt = "menu,menuone,noselect"

			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			-- Improve LSPs UI
			local icons = {
				Class = " ",
				Color = " ",
				Constant = " ",
				Constructor = " ",
				Enum = " ",
				EnumMember = " ",
				Event = " ",
				Field = " ",
				File = " ",
				Folder = " ",
				Function = "󰊕 ",
				Interface = " ",
				Keyword = " ",
				Method = "ƒ ",
				Module = "󰏗 ",
				Property = " ",
				Snippet = " ",
				Struct = " ",
				Text = " ",
				Unit = " ",
				Value = " ",
				Variable = " ",
			}

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind = lspkind.cmp_format({ symbol_map = icons, mode = "symbol_text", maxwidth = 50 })(
							entry,
							vim_item
						)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "

						return kind
					end,
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" }, -- text within current buffer
					{ name = "path" }, -- file system paths
					{ name = "emoji" },
					{ name = "cmp-dbee" },
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = {
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							-- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
							cmp.select_next_item()
						-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
						-- this way you will only jump inside the snippet region
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
			})
		end,
	},
}
