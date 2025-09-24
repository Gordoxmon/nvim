return {
  -- Mason para instalar servidores LSP automaticamente
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
      ensure_installed = { "lua_ls", "ts_ls" },
    },
    config = function(_, opts)
      require("mason").setup()
      -- Ensure listed servers are installed without mason-lspconfig
      local registry = require("mason-registry")
      for _, name in ipairs(opts.ensure_installed or {}) do
        local ok, pkg = pcall(registry.get_package, name)
        if ok then
          if not pkg:is_installed() then
            pkg:install()
          end
        end
      end
    end,
  },

  -- Mason-lspconfig (usado apenas em Neovim < 0.11)
  {
    "williamboman/mason-lspconfig.nvim",
    enabled = vim.fn.has("nvim-0.11") == 0,
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "lua_ls", "ts_ls" },
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end,
  }
}
