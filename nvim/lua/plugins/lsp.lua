return {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim", -- This bridge plugin is crucial
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "ruff" }, -- Ensure ruff_lsp and pyright are installed
      })

      -- This sets up the individual LSP servers once they are installed by Mason
      require("lspconfig").ruff.setup({
        -- You can add any specific configurations for ruff_lsp here
        -- For example, to pass arguments to ruff:
        -- settings = {
        --   args = { "--fix" },
        -- },
      })

      -- It's common to also set up pyright for type checking alongside ruff for linting/formatting
     --  require("lspconfig").pyright.setup({
     --    -- Pyright specific configurations
     --  })

      -- Global LSP keybindings (consider adding these if you don't have them)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP: Go to Definition' })
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'LSP: Go to Declaration' })
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'LSP: Go to References' })
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'LSP: Go to Implementation' })
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'LSP: Rename' })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP: Code Action' })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'LSP: Hover Documentation' })
      vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, { desc = 'LSP: Format' })
    end,
  }
