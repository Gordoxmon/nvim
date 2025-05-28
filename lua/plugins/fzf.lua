return {
 {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    keys = {
      { "<leader>ff", function() require("fzf-lua").files() end,      desc = "FZF: Find files" },
      { "<leader>fg", function() require("fzf-lua").live_grep() end,  desc = "FZF: Live grep" },
      { "<leader>fb", function() require("fzf-lua").buffers() end,    desc = "FZF: Buffers" },
      { "<leader>fh", function() require("fzf-lua").help_tags() end,  desc = "FZF: Help tags" },
    },
    opts = { "telescope" },  -- telescope‑style UI for familiarity
  }
}
