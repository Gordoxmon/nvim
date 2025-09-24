return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME },
              },
              completion = { callSnippet = 'Replace' },
              diagnostics = { globals = { 'vim' } },
            },
          },
        },
      },
    },
    config = function(_, opts)
      local blink = require('blink.cmp')

      -- Diagnostics UI
      vim.diagnostic.config({
        virtual_text = { spacing = 4, prefix = '●' },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = 'rounded', source = 'always', header = '', prefix = '' },
      })

      -- on_attach & keymaps
      local function on_attach(_client, bufnr)
        local o = { buffer = bufnr, silent = true }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', o, { desc = 'Go to definition' }))
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', o, { desc = 'Go to declaration' }))
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', o, { desc = 'Go to references' }))
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', o, { desc = 'Go to implementation' }))
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, vim.tbl_extend('force', o, { desc = 'Go to type definition' }))
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', o, { desc = 'Hover documentation' }))
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, vim.tbl_extend('force', o, { desc = 'Signature help' }))
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', o, { desc = 'Rename symbol' }))
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', o, { desc = 'Code actions' }))
        vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, vim.tbl_extend('force', o, { desc = 'Format buffer' }))
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, vim.tbl_extend('force', o, { desc = 'Previous diagnostic' }))
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, vim.tbl_extend('force', o, { desc = 'Next diagnostic' }))
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, vim.tbl_extend('force', o, { desc = 'Show diagnostic' }))
        vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, vim.tbl_extend('force', o, { desc = 'Diagnostic list' }))
      end

      local is_new_api = type(vim.lsp.config) == 'function' and type(vim.lsp.enable) == 'function'

      for server, cfg in pairs(opts.servers) do
        cfg.capabilities = blink.get_lsp_capabilities(cfg.capabilities)
        cfg.on_attach = on_attach

          vim.lsp.config(server, cfg)
          vim.lsp.enable(server)
      end
    end,
  },
}

