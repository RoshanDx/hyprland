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
          -- "gopls",
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
    },
    config = function()
      local on_attach = function(_, bufnr)
        local keymaps = vim.keymap
        local bufopts = { noremap = true, silent = true, buffer = bufnr }

        keymaps.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
        keymaps.set("n", "]d", vim.diagnostic.goto_next, bufopts)
        keymaps.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        keymaps.set("n", "gd", vim.lsp.buf.definition, bufopts)
        keymaps.set("n", "gr", vim.lsp.buf.references, bufopts)
        keymaps.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        keymaps.set("n", "K", vim.lsp.buf.hover, bufopts)
        keymaps.set("n", "<leader>k", vim.lsp.buf.signature_help, bufopts)
        keymaps.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
        keymaps.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
        keymaps.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "<space>fc", function()
          vim.lsp.buf.format({ async = true })
        end, bufopts)
      end

      local lspconfig = require("lspconfig")
      local util = require("lspconfig/util")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

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
