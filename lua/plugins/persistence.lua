return
{
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { -- configurações opcionais
        dir = vim.fn.stdpath("state") .. "/sessions",
        options = { "buffers", "curdir", "tabpages", "winsize" },
    },
}
