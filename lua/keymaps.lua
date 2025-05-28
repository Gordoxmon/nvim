-- Convenience Keymaps
local keymap = vim.keymap
keymap.set("n", "<leader>w", ":w<CR>",   { desc = "Save file" })
keymap.set("n", "<leader>q", ":q<CR>",   { desc = "Quit" })
keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear highlights" })


---------------------------------------------------------------------
-- Disable Arrow Keys in NORMAL mode
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

---------------------------------------------------------------------
