local opt = vim.opt

opt.number = true              -- Absolute line numbers
opt.relativenumber = true      -- Relative numbers help with jumps
opt.termguicolors = true       -- True‑color support
opt.signcolumn = "yes"         -- Always show the sign column
opt.cursorline = true          -- Highlight current line

---------------------------------------------------------------------
-- Indentation & Tabs
opt.expandtab   = true         -- Convert tabs to spaces
opt.shiftwidth  = 4            -- Spaces per indent
opt.tabstop     = 4            -- Display width of a tab
opt.smartindent = true         -- Smart autoindenting

---------------------------------------------------------------------
-- Searching
opt.ignorecase  = true         -- Case‑insensitive by default…
opt.smartcase   = true         -- …but smart when capitals are used
opt.hlsearch    = true         -- Highlight matches
opt.incsearch   = true         -- Incremental search

---------------------------------------------------------------------
-- Performance
opt.lazyredraw  = true
opt.updatetime  = 300          -- Faster CursorHold events

---------------------------------------------------------------------
-- Files
opt.swapfile    = false
opt.backup      = false
opt.undofile    = true         -- Persistent undo

---------------------------------------------------------------------
-- Clipboard
opt.clipboard = "unnamedplus"  -- Share with system clipboard

---------------------------------------------------------------------
-- GUI Font (Neovide / VSCode etc.)
opt.guifont = "JetBrainsMonoNerd Font:h14"
