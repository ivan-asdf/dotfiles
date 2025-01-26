require('init')
require('kanagawa').setup({
  typeStyle = { bold = true },
})

vim.cmd.colorscheme 'kanagawa'
vim.o.background = "dark"

