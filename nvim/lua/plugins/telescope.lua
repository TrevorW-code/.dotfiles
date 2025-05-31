return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    telescope.setup()

    -- Keymaps (set after telescope is loaded)
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    map("n", "<leader>pf", builtin.find_files, opts)
    map("n", "<C-p>", builtin.git_files, opts)
    map("n", "<leader>ps", function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end, opts)
    map("n", "<leader>vh", builtin.help_tags, opts)
  end,
}
