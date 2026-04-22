return {
  -- {
  --   "samharju/synthweave.nvim",
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000,
  --   config = function()
  --        vim.cmd.colorscheme("synthweave")
  --   end
  -- }
  --   {
  --   "cpea2506/one_monokai.nvim",
  -- }

  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   priority = 1000,
  --   config = true,
  --   opt = {
  --     terminal_colors = true, -- add neovim terminal colors
  --     undercurl = true,
  --     underline = true,
  --     bold = true,
  --     italic = {
  --       strings = true,
  --       emphasis = true,
  --       comments = true,
  --       operators = false,
  --       folds = true,
  --     },
  --     strikethrough = true,
  --     invert_selection = false,
  --     invert_signs = false,
  --     invert_tabline = false,
  --     inverse = true, -- invert background for search, diffs, statuslines and errors
  --     contrast = "",  -- can be "hard", "soft" or empty string
  --     palette_overrides = {},
  --     overrides = {},
  --     dim_inactive = false,
  --     transparent_mode = true,
  --   }
  -- }

  {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.everforest_enable_italic = true
      vim.g.everforest_background = 'soft'
      vim.g.everforest_transparent = true
    end
  }

  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 }
  -- {
  --   "lunarvim/synthwave84.nvim",
  --   config = function()
  --     require("synthwave84").setup({
  --       glow = {
  --         error_msg = true,
  --         type2 = true,
  --         func = true,
  --         keyword = true,
  --         operator = false,
  --         buffer_current_target = true,
  --         buffer_visible_target = true,
  --         buffer_inactive_target = true,
  --       },
  --       transparent = true,
  --     })
  --   end,
  -- },

  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     style = "dark",
  --   },
  -- },
}
