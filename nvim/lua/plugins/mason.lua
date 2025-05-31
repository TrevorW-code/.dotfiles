return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Setup dapui
      dapui.setup()

      -- Auto open/close dapui
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Key mappings
      vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
      vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })
      vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
      vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: Toggle UI' })

      -- Signs
      vim.api.nvim_set_hl(0, 'DapStoppedLine', { link = 'Visual' })
      vim.fn.sign_define('DapBreakpoint', { text = '📍', texthl = 'DapBreakpoint' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '⚠️', texthl = 'DapBreakpointCondition' })
      vim.fn.sign_define('DapStopped', { text = '👉', texthl = 'DapStopped', linehl = 'DapStoppedLine' })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python", -- Make sure nvim-dap-python is a dependency here
    },
    config = function()
      local dap = require("dap") -- Get dap instance here for configurations

      require("mason-nvim-dap").setup({
        ensure_installed = { "python" }, -- This ensures debugpy is installed
        automatic_installation = true,
        handlers = {
          -- This 'python' key corresponds to the debugpy adapter
          -- that mason-nvim-dap sets up for nvim-dap-python.
          python = function(tool)
            -- 'tool.path' is the path to the debugpy executable (or the python executable running debugpy)
            require("dap-python").setup(tool.path)

            -- Now add your custom Python debugging configurations
            table.insert(dap.configurations.python, {
              type = 'python',
              request = 'launch',
              name = 'Launch file',
              program = '${file}',
              pythonPath = function()
                return tool.path -- Use the path provided by mason-nvim-dap
              end,
            })

            table.insert(dap.configurations.python, {
              type = 'python',
              request = 'launch',
              name = 'Run as module',
              module = function()
                return vim.fn.input('Module to run (e.g. app.main): ')
              end,              
              justMyCode = false,
              console = 'integratedTerminal',
              pythonPath = function()
                return tool.path  -- use debugpy path
              end,
            })

            table.insert(dap.configurations.python, {
              type = 'python',
              request = 'launch',
              name = 'Launch file with arguments',
              program = '${file}',
              args = function()
                local args_string = vim.fn.input('Arguments: ')
                return vim.split(args_string, " +")
              end,
              pythonPath = function()
                return tool.path
              end,
            })
          end,
        },
      })
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
}
