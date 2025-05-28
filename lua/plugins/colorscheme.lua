return {
{
    "Shatur/neovim-ayu",
    priority = 1000,
    lazy = false,  -- load immediately
    config = function()
      require("ayu").setup({ mirage = false })  -- false = ayu‑dark; true = ayu‑mirage
      vim.cmd.colorscheme("ayu")
    end,
  }
}
