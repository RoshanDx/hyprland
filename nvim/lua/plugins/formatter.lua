return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>bf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[B]uffer [F]ormat",
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			-- Disable "format_on_save lsp_fallback" for languages that don't
			-- have a well standardized coding style. You can add additional
			-- languages here or re-enable it for the disabled ones.
			local disable_filetypes = { c = true, cpp = true }
			local lsp_format_opt
			if disable_filetypes[vim.bo[bufnr].filetype] then
				lsp_format_opt = "never"
			else
				lsp_format_opt = "fallback"
			end
			return {
				timeout_ms = 500,
				lsp_format = lsp_format_opt,
			}
		end,
		formatters_by_ft = { -- NOTE: make sure dependencies are installed in Mason or externally
			lua = { "stylua" },
			json = { "jq" },
			go = { "goimports", "gofmt", "golines" },
			yaml = { "yq" },
			yml = { "yq" },
			xml = { "yq" },
			bash = { "shfmt" },
			sh = { "shfmt" },

			-- Conform can also run multiple formatters sequentially
			-- python = { "isort", "black" },
			--
			-- You can use 'stop_after_first' to run the first available formatter from the list
			-- javascript = { "prettierd", "prettier", stop_after_first = true },
		},
		formatters = {
			yq = {
				command = "yq",
				args = {
					"eval",
					".",
					"-", -- equivalent to formatting input from stdin
				},
				stdin = true,
			},
			-- 	xmllint = { -- uncomment if want to use existing xmllint in system [libxml2]
			-- 		command = "xmllint",
			-- 		args = {
			-- 			"--format",
			-- 			"-",
			-- 		},
			-- 		stdin = true,
			-- 	},
		},
	},
}
