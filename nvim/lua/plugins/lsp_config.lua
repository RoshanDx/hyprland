return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "󰮏",
						package_uninstalled = "",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = "williamboman/mason.nvim",
		event = "BufReadPre",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"gopls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			-- Useful status updates for LSP.
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			local on_attach = function(_, bufnr)
				local bufopts = { noremap = true, silent = true, buffer = bufnr }

				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(
						mode,
						keys,
						func,
						{ noremap = true, silent = true, buffer = bufnr, desc = "LSP: " .. desc }
					)
				end

				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)

				-- Rename the variable under your cursor.
				--  Most Language Servers support renaming across files, etc.
				map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

				-- Execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

				-- Find references for the word under your cursor.
				map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

				-- Jump to the implementation of the word under your cursor.
				--  Useful when your language has ways of declaring types without an actual implementation.
				map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

				-- Jump to the definition of the word under your cursor.
				--  This is where a variable was first declared, or where a function is defined, etc.
				--  To jump back, press <C-t>.
				map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

				-- WARN: This is not Goto Definition, this is Goto Declaration.
				--  For example, in C this would take you to the header.
				map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				-- Fuzzy find all the symbols in your current document.
				--  Symbols are things like variables, functions, types, etc.
				map("grs", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

				-- Fuzzy find all the symbols in your current workspace.
				--  Similar to document symbols, except searches over your entire project.
				map("grS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				-- Jump to the type of the word under your cursor.
				--  Useful when you're not sure what type a variable is and you want to see
				--  the definition of its *type*, not where it was *defined*.
				map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

				-- Add border to signature help
				local function bordered_signature_help()
					return vim.lsp.buf.signature_help(vim.tbl_deep_extend("force", bufopts, {
						border = "rounded",
					}))
				end

				map("grk", bordered_signature_help, "[D]isplay Signature")
			end

			local lspconfig = require("lspconfig")
			local util = require("lspconfig/util")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				},
				virtual_text = {
					source = "if_many",
					spacing = 2,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
			})

			-- Disable if need icons, the top config doesnt override the icons for whatever reason
			-- Comment out the top config and uncomment this bottom code
			-- vim.diagnostic.config({
			-- 	severity_sort = true,
			-- 	float = { border = "rounded", source = "if_many" },
			-- })
			-- local signs = {
			-- 	{ name = "DiagnosticSignError", text = "󰅚" },
			-- 	{ name = "DiagnosticSignWarn", text = "󰀪" },
			-- 	{ name = "DiagnosticSignHint", text = "󰌶" },
			-- 	{ name = "DiagnosticSignInfo", text = "󰋽" },
			-- }
			--
			-- for _, sign in ipairs(signs) do
			-- 	vim.fn.sign_define(sign.name, { text = sign.text, texthl = sign.name, numhl = "" })
			-- end

			-- lua
			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				capabalities = capabilities,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
							},
						},
					},
				},
			})

			-- go
			lspconfig.gopls.setup({
				on_attach = on_attach,
				capabalities = capabilities,
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gowork", "gotmpl" },
				root_dir = util.root_pattern("go.work", "go.mod", ".git"),
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						analyses = {
							unusedparams = true,
						},
					},
				},
			})
		end,
	},
}
