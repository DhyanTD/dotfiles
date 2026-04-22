return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local custom_theme = require('lualine.themes.16color')
    for _, mode in pairs(custom_theme) do
      for _, section in pairs(mode) do
        section.bg = "none"
      end
    end
    require('lualine').setup({
      options = {
        theme = custom_theme,
      }
    })
  end
}
