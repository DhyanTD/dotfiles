vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
-- vim.cmd.colorscheme "one_monokai"
-- vim.cmd([[colorscheme synthwave84]])
-- vim.cmd("colorscheme gruvbox")
-- vim.cmd.colorscheme('everforest')
-- vim.cmd.colorscheme('catppuccin')
-- vim.cmd.colorscheme('tokyonight.nvim')


-- this is for transparent background, since we are using catppuccin this is not needed
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     local groups = {
--       "Normal",
--       "NormalFloat",
--       "SignColumn",
--       "EndOfBuffer",
--
--       "TelescopeNormal",
--       "TelescopeBorder",
--       "TelescopePromptNormal",
--       "TelescopeResultsNormal",
--       "TelescopePreviewNormal",
--
--       "NeoTreeNormal",
--       "NeoTreeNormalNC",
--       "NeoTreeEndOfBuffer",
--     }
--
--     for _, group in ipairs(groups) do
--       vim.api.nvim_set_hl(0, group, { bg = "none" })
--     end
--   end,
-- })

-- vim.cmd("colorscheme everforest")
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
-- vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
-- vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
-- vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "none" })
--

-- making the terminal transparent
vim.api.nvim_create_autocmd({ "ColorScheme", "TermOpen" }, {
  callback = function()
    local groups = {
      "Normal",
      "NormalFloat",
      "SignColumn",
      "EndOfBuffer",
      "Terminal",
      "FloatBorder",
      -- "barbar",
      -- "lualine"
    }

    for _, group in ipairs(groups) do
      vim.api.nvim_set_hl(0, group, { bg = "none" })
    end
  end,
})

vim.g.mapleader = " "

vim.opt.swapfile = false
vim.opt.smartcase = true


-- use real terminal colors
vim.opt.termguicolors = true

vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
vim.wo.number = true
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})
vim.keymap.set("n", "y", '"+y')
vim.keymap.set("n", "yy", '"+yy')
vim.keymap.set("n", "Y", '"+Y')
vim.keymap.set("x", "y", '"+y')
vim.keymap.set("x", "Y", '"+Y')

vim.keymap.set("n", "x", '"+x')
vim.keymap.set("n", "d", '"+d')
vim.keymap.set("n", "dd", '"+dd')

vim.keymap.set("x", "x", '"+x')
vim.keymap.set("x", "d", '"+d')

vim.keymap.set("n", "p", '"+p')
vim.keymap.set("n", "P", '"+P')
vim.keymap.set("x", "p", '"+p')
vim.keymap.set("x", "P", '"+P')

-- for error navigation
vim.keymap.set("n", "er", vim.diagnostic.goto_next)
vim.keymap.set("n", "re", vim.diagnostic.goto_prev)

--for ufo folding
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- transparent back
-- vim.g.transparent_groups = vim.list_extend(vim.g.transparent_groups or {}, { "ExtraGroup" })
-- require("transparent").clear_prefix("NeoTree")
-- require("transparent").clear_prefix("lualine")
-- require("transparent").clear_prefix("telescope")
-- require("transparent").clear_prefix("barbar")
-- require("transparent").clear_prefix("gitsigns")
