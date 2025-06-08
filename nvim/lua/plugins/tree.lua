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
        position = "float", 
          mapping_options = {
              noremap = true,
              nowait = true,
        },
  },
      filesystem = {
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      close_if_last_window = true,
      }
  },
  event_handlers = {
    {
      event = "neo_tree_window_after_open",
      handler = function(args)
        -- Force Neo-tree to always stay at the far left
        vim.cmd("wincmd H")
      end,
    },
  },
}
