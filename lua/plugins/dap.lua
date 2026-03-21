return {
  -- Required for nvim-dap-ui
  {
    "nvim-neotest/nvim-nio",
  },

  -- Core debugger
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      -- C++ adapter using codelldb
      dap.adapters.cpp = {
        type = "server",
        host = "127.0.0.1",
        port = 13000,
        executable = {
          -- NOTE: make sure codelldb is installed and set the right absolute path
          command = "/home/jelemikun/tools/codelldb/extension/adapter/codelldb",
          args = { "--port", "13000" },
        },
      }

      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "cpp",
          request = "launch",
          program = function()
            local recomp = vim.fn.input("Have you recompiled the program if there were changes? [Y/n]: ")

            if recomp:lower() == "n" then
              print("Please recompile your program before running the debugger!")
              return "" -- abort launch
            end

            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          runInTerminal = true,
        },
      }

      -- Keymaps for debugging
      -- Continue / step
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP Continue" })
      vim.keymap.set("n", "<F9>", dap.step_over, { desc = "DAP Step Over" })
      vim.keymap.set("n", "<F10>", dap.step_into, { desc = "DAP Step Into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })

      -- Breakpoints
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "DAP Set Conditional Breakpoint" })
      vim.keymap.set("n", "<leader>dl", function()
        dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end, { desc = "DAP Set Logpoint" })
      vim.keymap.set("n", "<leader>dD", function()
        require("dap").clear_breakpoints()
        print("All breakpoints cleared!")
      end, { desc = "DAP Clear All Breakpoints" })

      -- REPL
      vim.keymap.set("n", "<leader>dr", function()
        require("dap").repl.open()
      end, { desc = "DAP Open REPL" })
      vim.keymap.set("n", "<leader>dR", function()
        if dap.repl.last_buf and vim.api.nvim_buf_is_valid(dap.repl.last_buf) then
          dap.repl.run_last()
        else
          print("No active REPL yet! Press <leader>dr to open one first.")
        end
      end, { desc = "DAP Run Last REPL Command" })

      -- Frames and Scopes
      vim.keymap.set("n", "<leader>df", function()
        require("dapui").float_element("frames")
      end, { desc = "DAP Show Frames" })

      vim.keymap.set("n", "<leader>ds", function()
        require("dapui").float_element("scopes")
      end, { desc = "DAP Show Scopes" })

      -- Evaluate expressions
      vim.keymap.set("n", "<leader>de", function()
        dap.eval(vim.fn.input("Expression: "))
      end, { desc = "DAP Evaluate Expression" })
      vim.keymap.set("v", "<leader>de", function()
        dap.eval(vim.fn.expand("<cword>"))
      end, { desc = "DAP Evaluate Expression (Visual)" })

      -- Run last
      vim.keymap.set("n", "<leader>dC", function()
        vim.schedule(function()
          require("dap").run_last()
        end)
      end, { desc = "DAP Run Last Configuration" })

      -- Disconnect / terminate
      vim.keymap.set("n", "<leader>dq", dap.disconnect, { desc = "DAP Disconnect" })
      vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "DAP Terminate Debugging" })

      -- Watch points
      vim.keymap.set("n", "<leader>dw", function()
        -- Ask user for variable name
        local var = vim.fn.input("Variable to watch: ")
        if var == "" then
          return
        end
        local dapui = require("dapui")

        -- Add to dap-ui watches panel
        dapui.eval(var)
      end, { desc = "DAP Add Watch Variable" })
      vim.keymap.set("n", "<leader>dW", function()
        require("dapui").open("watches") -- pinned, will stay open
      end, { desc = "DAP Open watches panel" })
    end, -- end of config function
  }, -- end of nvim-dap table

  -- DAP UI
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui").setup({
        icons = { expanded = "▾", collapsed = "▸" },
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" }, -- expand/collapse tree nodes
          open = "o", -- jump to source line
          remove = "d", -- delete single element (breakpoint)
          edit = "e", -- edit element (like condition/log)
          repl = "r", -- send element to REPL
          toggle = "t", -- toggle element open/close
        },
        element_mappings = {},
        expand_lines = false,
        force_buffers = true,
        controls = {
          enabled = true,
          element = "repl",
          icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "↻",
            terminate = "□",
          },
        },
        render = { max_type_length = nil },
        layouts = {
          {
            elements = { "scopes", "watches" },
            size = 40,
            position = "right",
          },
          {
            elements = { "breakpoints", "stacks", "repl" },
            size = 15,
            position = "bottom",
          },
        },
        floating = {
          border = "rounded",
          mappings = { close = { "q", "<Esc>" } },
        },
      })
    end,
  },

  -- Virtual text (Treesitter integration enabled)
  {
    "theHamsta/nvim-dap-virtual-text",
    version = "v0.9.0", -- pin stable version to avoid "tab" error
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = true,
        show_stop_reason = true,
        virt_text_pos = "eol",
        all_frames = false,
        virt_lines = false,
      })
    end,
  },
}
