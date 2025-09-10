return {
  -- Comment plugin
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },

  -- Surround plugin
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- Better text objects
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        },
      }
    end,
  },

  -- Highlight word under cursor
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
  },

  -- Alpha Dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Hollow Knight ASCII art with colors
      local ascii_art = {
        "",
        "                                                                                                                      ",
        "                                                                                                                      ",
        "                                                                                                                      ",
        "                                                 .o                                                                   ",
        "                                               'kK:                                                                   ",
        "                                             ,ON0c                                                                    ",
        "                                           'OMW0;                                       .ll.                          ",
        "                                          ,MMMX,               .o                       .kx..                         ",
        "                                        'kMMMX.              'kWX                       .kx..                         ",
        "                                       .OMMMX.              'OWk                        .kx..                         ",
        "                                      kNMMMWk              xWMXl                        .dx,.                         ",
        "                                    .dWMMMWO             .dWMWl                         ..o0.                         ",
        "                                   'WMMMMWx            .dMMMWk'                    .lKcKo,o0..                        ",
        "                                  :NMMMMWK:           .dMMMWk'                   .'o0; ;0c.lX.                        ",
        "                                 :XMMMMMXc          .dXMMMW0.                 ..dKX0OKdKO;.:W..                       ",
        "                                :KMMMMMN,          oWMMMMMX          .dKc  'coXXK0o. ;;;  .:N'.                       ",
        "                                0MMMMMWx.       .oWMMMMMW0       ,;kKKXXXKKKKOcc           .,N..                      ",
        "                               OWMMMMMX.     .k0NMMMMMMXo.  ..:kkXXXXXXXXXKo'.             .'W'.                      ",
        "                              kWMMMMMMWk,.'xkMMMMMMMMMo.  l.:cdKXX000KK0k;,'.              .'X;.                      ",
        "                             .MMMMMMMMMMMMMMMMMMMMMMMx'.,,,;;;;;oo,,,;,          ..........',:Wl..                    ",
        "                            'WMMMMMMMMMMMMMMMMMMMMMWOc,,,,,,,,,,;;:::::,...;lllooxxxxxxxxxxxkOWKxooll..               ",
        "                           .lN..xNMMMMMMMMMMMMMMMWOl;;,,,,,,;::clldxxxk0Oxxl;;;;,............'0xlc;;;dc.              ",
        "                           cK,   dMMMMMMNXNMMMMMWO:;,,,,;;cllxOO00xdxxd:...                  ..Ko..  .;ol.            ",
        "                           ck    dMMMWol. .oMMMOl;;;,,,,:ckOOdllcccc;;,,.                    ..Ko..    .,dd.          ",
        "                           cK,  'OMNd      :WKo,,;;;;;;;,,,;;;;:::;;;;;;;'.                   .dd;.     .,Ol.         ",
        "                         ..lNWOOWMMK.   .:0Xo:,,;;;,,;;;;;;;;;,,,,;;;;;;;;'                   ..kx.      .'W..        ",
        "       'o.           .lllKKKKO::KWWWNooodxo;;,;;;;;;;,,,',;;;;;;;;,,,,;;;'.                    .kk..     .,N..        ",
        "       ,xo.      ;:kXXXKl:.       ...,:::;,,,;;;;;;;;;;;;;,,,,,;;;;;;;,,.                      .cxl.    .;N'.         ",
        "        .,dl;,:Okddo;..               .'',;;.;;;;;;,,,;;;;;;;;,,,;;;;;;;;'                      .oK.    .:N..         ",
        "        ..x0NXd,.                    .,;,,;;,,;;;;;;,,,,;;;;;;;;';;;;;;;;;'                     .oK..  .:k:.          ",
        "       .;;,.;dl..                   ';;;;,';;;',;;;;;;;;,,;;;;;;;,';;;;;;'.                     .oK'...cxc.           ",
        "             .,xoo..               ';;;;;,';;;;',;;;;;;;;,,;;;;;;;.;;;;'.                        .:N''lxl.            ",
        "               .',ol,..            ';;;;;,,;;;;;,';;;;;;;;',;;;;;;;','.                          .;W;ok:.             ",
        "                  .,lxd,.          .;;;;'';;;;;;,';;;;;;;;;',;;;;;;;'.                           .:WlK;.              ",
        "                     ..ldx;.        .     ':;;;;,';;;;;;;;;;',;;;;;,.                           .,lWk,.               ",
        "                        ..ldlc..          ':;;;;..,,;;;;;;,..',,,,.                           ..lkklW,.               ",
        "                           .;:x::'.        ....     .,;;,.                                  .'cxo:,;M'.               ",
        "                              .cldxo''..                                                  .':ko;...,M'.               ",
        "  .dddddo.....                   ..'ddxd;...                                            .:dxd'.   .,W'.               ",
        "  .kkc;;;xxxxdlll....                ..'lxxxll'..                                    ..cd:...    .;X,.                ",
        "   .,ooc:....';;;xxxxd:::;...             ..;;dxxd:::;....                        ':cxx:.        .;N..                ",
        "     .'clxx;'.........cclldxxd,'''.            ..'cccldxxxx,,''...           .'''ooc:..          .cK.                 ",
        "         ..ldddo.....    .....dddddc      .            ....odddxxddd;'''',,lxxxxx,.             .oK..                 ",
        "             ..'xxxollll...........'..   'c.                ....,,''lxONOOOOkxddol,............:dc.                   ",
        "                 ..',;;;dxxxxd:::::::c:,. .:::::;;;;:;;;;;:::::cxxx'  .,'..,;;;;;;lxxxxxxxxxxxx:.                     ",
        "                         .....cccccccccl'..llllllllllllllllcccc:....               ............                       ",
        "                                                                                                                      ",
        "                                                                                                                      ",
        "                                                                                                                      ",
        "",
      }


      -- Set up the dashboard with simple coloring
        dashboard.section.header.val = ascii_art
            -- Configure buttons
      dashboard.section.buttons.val = {
        dashboard.button("f", "📁 Find File", ":FzfLua files<CR>"),
        dashboard.button("r", "📋 Recent Files", ":FzfLua oldfiles<CR>"),
        dashboard.button("g", "🔍 Grep", ":FzfLua live_grep<CR>"),
        dashboard.button("c", "⚙️  Config", ":e ~/.config/nvim/init.lua<CR>"),
        dashboard.button("s", "💾 Restore Session", [[:lua require("persistence").load()<cr>]]),
        dashboard.button("l", "📦 Lazy", ":Lazy<CR>"),
        dashboard.button("q", "🚪 Quit", ":qa<CR>"),
      }

      -- Add some footer text
      dashboard.section.footer.val = {
        "",
        "    ╔══════════════════════════════════════════════════════════════╗",
        "    ╚══════════════════════════════════════════════════════════════╝",
        "",
      }

      -- Set up the dashboard
      alpha.setup(dashboard.opts)

      -- Auto-hide the dashboard when opening a file
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        desc = "disable status and tabline for alpha",
        callback = function()
          vim.opt.laststatus = 0
          vim.opt.showtabline = 0
        end,
      })

      vim.api.nvim_create_autocmd("BufUnload", {
        pattern = "<buffer>",
        desc = "enable status and tabline after alpha",
        callback = function()
          vim.opt.laststatus = 3
          vim.opt.showtabline = 2
        end,
      })
    end,
  },
}
