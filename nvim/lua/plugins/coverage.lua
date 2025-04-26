return {
  "andythigpen/nvim-coverage",
  version = "*",
  config = function()
    require("coverage").setup({
      auto_reload = true,
    })
  end,
  keys = {
    { "<leader>cl", function() require("coverage").load() end,    desc = "Load Coverage" },
    { "<leader>ct", function() require("coverage").toggle() end,  desc = "Toggle Coverage" },
    { "<leader>cs", function() require("coverage").summary() end, desc = "Show Coverage Summary" },
  }
}
