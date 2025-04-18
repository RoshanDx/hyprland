  return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {"lua"},
        auto_install = true,
        highlight = {
          enable = true,
        },
        autotag = {
          enable = true,
        },
      })
    end,
}
