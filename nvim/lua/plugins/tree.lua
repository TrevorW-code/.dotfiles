return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = false,   
  opts = {
      window = {
        position = "left", 
          mapping_options = {
              noremap = true,
              nowait = true,
        },
  },
      filesystem = {
        hijack_netrw_behavior = "open_default", 
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      close_if_last_window = true,
      }
  },
}
