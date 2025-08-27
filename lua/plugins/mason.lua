return {
  -- Mason para instalar servidores LSP automaticamente
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {},
  },

  -- Mason-lspconfig conecta mason com nvim-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "lua_ls", "pyright", "tsserver" }, -- servidores que quer garantir
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end,
  }
}
