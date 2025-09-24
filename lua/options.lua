local opt = vim.opt

-- UI
opt.number = true              -- Absolute line numbers
opt.relativenumber = true      -- Relative numbers help with jumps
opt.termguicolors = true       -- True‑color support
opt.signcolumn = "yes"         -- Always show the sign column
opt.cursorline = true          -- Highlight current line
opt.wrap = false               -- Don't wrap lines
opt.scrolloff = 8              -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8          -- Keep 8 columns left/right of cursor
opt.colorcolumn = "80"         -- Show column at 80 characters
opt.showmode = false           -- Don't show mode in command line
opt.cmdheight = 1              -- Command line height
opt.pumheight = 10             -- Popup menu height
opt.pumblend = 10              -- Popup menu transparency
opt.winblend = 0               -- Window transparency
opt.conceallevel = 0           -- Don't hide concealed text
opt.showtabline = 2            -- Always show tabline
opt.laststatus = 3             -- Global statusline

---------------------------------------------------------------------
-- Indentation & Tabs
opt.expandtab = true           -- Convert tabs to spaces
opt.shiftwidth = 4             -- Spaces per indent
opt.tabstop = 4                -- Display width of a tab
opt.softtabstop = 4            -- Number of spaces for tab in insert mode
opt.smartindent = true         -- Smart autoindenting
opt.autoindent = true          -- Copy indent from current line
opt.breakindent = true         -- Wrap lines with indent
opt.shiftround = true          -- Round indent to multiple of shiftwidth

---------------------------------------------------------------------
-- Searching
opt.ignorecase = true          -- Case‑insensitive by default…
opt.smartcase = true           -- …but smart when capitals are used
opt.hlsearch = true            -- Highlight matches
opt.incsearch = true           -- Incremental search
opt.grepprg = "rg --vimgrep"   -- Use ripgrep for grep
opt.grepformat = "%f:%l:%c:%m" -- Grep format

---------------------------------------------------------------------
-- Performance
opt.lazyredraw = true
opt.updatetime = 300           -- Faster CursorHold events
opt.timeoutlen = 300           -- Time to wait for key sequence
opt.ttimeoutlen = 0            -- Time to wait for key codes
opt.redrawtime = 10000         -- Time to wait for syntax highlighting

---------------------------------------------------------------------
-- Files
opt.swapfile = false
opt.backup = false
opt.writebackup = false        -- Don't create backup before overwriting
opt.undofile = true            -- Persistent undo
opt.undolevels = 10000         -- Maximum number of undo levels
opt.autowrite = true           -- Auto save before commands like :next
opt.autoread = true            -- Auto read file when changed outside vim
opt.confirm = true             -- Confirm before closing unsaved files

---------------------------------------------------------------------
-- Clipboard
opt.clipboard = "unnamedplus"  -- Share with system clipboard

---------------------------------------------------------------------
-- Completion
opt.completeopt = "menu,menuone,noselect" -- Completion options
opt.shortmess:append("c")      -- Don't show completion messages
opt.wildmode = "longest:full,full" -- Command line completion mode
opt.wildoptions = "pum"        -- Show popup menu for wildmenu

---------------------------------------------------------------------
-- Splits
opt.splitright = true          -- Vertical splits go to the right
opt.splitbelow = true          -- Horizontal splits go below
opt.splitkeep = "screen"       -- Keep screen position when splitting

---------------------------------------------------------------------
-- Mouse
opt.mouse = "a"                -- Enable mouse in all modes
opt.mousefocus = true          -- Focus follows mouse

---------------------------------------------------------------------
-- Formatting
opt.formatoptions = "jcroqlnt" -- Format options
opt.textwidth = 80             -- Maximum line width

---------------------------------------------------------------------
-- GUI Font (Neovide / VSCode etc.)
opt.guifont = "JetBrainsMonoNerd Font:h14"

---------------------------------------------------------------------
-- Folding (using treesitter)
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false         -- Don't fold by default
opt.foldlevel = 99             -- High fold level

---------------------------------------------------------------------
-- Session
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

---------------------------------------------------------------------
-- Safety: keep normal buffers editable
-- Some plugins open non-editable windows; if you paste there, you get E21.
-- Ensure real file buffers stay modifiable and not readonly when entered.
vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("EnsureModifiable", { clear = true }),
    pattern = "*",
    callback = function(args)
        local bufopts = vim.bo[args.buf]
        if bufopts.buftype == "" then
            -- Only touch normal file buffers
            bufopts.modifiable = true
            bufopts.readonly = false
        end
    end,
})

-- Helper: quickly fix current buffer if needed
vim.api.nvim_create_user_command("ForceModifiable", function()
    vim.bo.modifiable = true
    vim.bo.readonly = false
end, { desc = "Make current buffer modifiable and not readonly" })
