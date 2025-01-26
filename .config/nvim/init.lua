require('init')

require('kanagawa').setup({
  typeStyle = { bold = true },
  background = {
      dark = "dragon",
      light = "wave"
  }
})
vim.cmd.colorscheme 'kanagawa'
vim.o.background = "dark"

