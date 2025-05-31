require("config.lazy")
vim.cmd.colorscheme("catppuccin")
vim.api.nvim_set_keymap('n', 'q', '<nop>', { noremap = true, silent = true })
vim.diagnostic.config({
  virtual_text = true,  -- show errors inline
  signs = true,         -- show signs in gutter
  underline = true,     -- underline the code
  update_in_insert = false,
  severity_sort = true,
})
vim.keymap.set('n', '<leader>qq', ':qall<CR>')
