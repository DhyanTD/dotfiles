-- return {
--   {
--     "nvim-neo-tree/neo-tree.nvim",
--     branch = "v3.x",
--     dependencies = {
--       "nvim-lua/plenary.nvim",
--       "nvim-tree/nvim-web-devicons",
--       "MunifTanjim/nui.nvim",
--     },
--     config = function()
--       vim.keymap.set('n', '<S-l>', ':Neotree filesystem reveal toggle right<CR>', {})
--     end
--   },
-- }


return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",

    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      -- toggle neo-tree
      vim.keymap.set('n', '<S-l>', ':Neotree filesystem reveal toggle right<CR>', {})

      -- neo-tree setup
      require("neo-tree").setup({
        window = {
          mappings = {
            ["Y"] = function(state)
              local node = state.tree:get_node()
              local path = node:get_id()

              -- make path relative to cwd
              local relative_path = vim.fn.fnamemodify(path, ":.")

              -- copy to system clipboard
              vim.fn.setreg("+", relative_path)

              print("Copied: " .. relative_path)
            end,
          },
        },
      })
    end
  },
}
