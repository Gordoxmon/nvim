-- lua/custom/plugins/copilot.lua
--
-- Copilot.vim + CopilotChat setup for Lazy.nvim
--
-- Keymaps
--   <leader>Cc  →  :CopilotChat           (open chat window)
--   <leader>Ct  →  toggle Copilot         (:Copilot enable/disable)
--
-- Save this file inside ~/.config/nvim/lua/custom/plugins/ and run :Lazy sync
-- -----------------------------------------------------------------------------

----------------------------------------------------
-- 1. KEYMAPS (no `require()` at startup)          --
----------------------------------------------------

-- Open Copilot Chat
vim.keymap.set('n', '<leader>Cc', '<cmd>CopilotChat<CR>', {
  desc = 'Open Copilot Chat',
})

-- Toggle Copilot suggestions (github/copilot.vim backend)
vim.keymap.set('n', '<leader>Ct', function()
  local status = vim.fn.execute 'Copilot status'
  if status:match 'Enabled' then
    vim.cmd 'Copilot disable'
    vim.notify 'Copilot disabled'
  else
    vim.cmd 'Copilot enable'
    vim.notify 'Copilot enabled'
  end
end, { desc = 'Toggle Copilot' })

----------------------------------------------------
-- 2. PLUGIN DECLARATIONS (Lazy‑format)            --
----------------------------------------------------
return {
  -------------------------------------------------------------------
  -- 2‑a. Copilot core (Vim‑script implementation)                  --
  -------------------------------------------------------------------
  {
    'github/copilot.vim', -- Vim‑script backend
    cmd = 'Copilot', -- lazy‑load on :Copilot
    event = 'InsertEnter', -- or any trigger you prefer
  },

  -------------------------------------------------------------------
  -- 2‑b. Copilot Chat                                             --
  -------------------------------------------------------------------
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' }, -- backend declared above
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    build = 'make tiktoken', -- required on macOS/Linux only
    opts = {}, -- see :h copilotchat‑config
    cmd = 'CopilotChat', -- lazy‑load on :CopilotChat
  },
}
