return {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "jay-babu/mason-nvim-dap.nvim",
        "theHamsta/nvim-dap-virtual-text",
    },
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
    { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },
  config = function()
    local mason_dap = require("mason-nvim-dap")
    local dap = require("dap")
    local ui = require("dapui")
    local dap_virtual_text = require("nvim-dap-virtual-text")

    -- Dap Virtual Text
    dap_virtual_text.setup()

    mason_dap.setup({
      ensure_installed = { "cppdbg", "python" },
      automatic_installation = true,
      handlers = {
        function(config)
          require("mason-nvim-dap").default_setup(config)
        end,
      },
    })

    -- Configurations
    dap.configurations = {
      c = {
        {
          name = "Launch file",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = false,
          MIMode = "lldb",
        },
        {
          name = "Attach to lldbserver :1234",
          type = "cppdbg",
          request = "launch",
          MIMode = "lldb",
          miDebuggerServerAddress = "localhost:1234",
          miDebuggerPath = "/usr/bin/lldb",
          cwd = "${workspaceFolder}",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
        },
      },
      	python = {
          {
            -- The first three options are required by nvim-dap
            type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
            request = "launch",
            name = "Launch file",

            -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

            program = "${file}", -- This configuration will launch the current file if used.
            pythonPath = function()
              local cwd = vim.fn.getcwd()

              -- 1. Check for local 'venv'
              local venv_path = cwd .. "/venv/bin/python"
              if vim.fn.executable(venv_path) == 1 then
                return venv_path
              end

              -- 2. Check for local '.venv'
              local dot_venv_path = cwd .. "/.venv/bin/python"
              if vim.fn.executable(dot_venv_path) == 1 then
                return dot_venv_path
              end

              -- 3. Check for 'python3' in PATH (most common modern default)
              local which_python3 = vim.fn.trim(vim.fn.system('which python3'))
              if vim.fn.executable(which_python3) == 1 then
                return which_python3
              end

              -- 4. Check for 'python' in PATH (legacy or specific setups)
              local which_python = vim.fn.trim(vim.fn.system('which python'))
              if vim.fn.executable(which_python) == 1 then
                return which_python
              end

              -- 5. Final fallback to the system default
              return "/usr/bin/python"
            end,
          },
      },
    }

    local vscode = require("dap.ext.vscode")
    local json = require("plenary.json")
    vscode.json_decode = function(str)
      return vim.json.decode(json.json_strip_comments(str))
    end

    vscode.load_launchjs()

    -- Dap UI

    ui.setup()

    vim.fn.sign_define("DapBreakpoint", { text = "🐞" })

    dap.listeners.before.attach.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      ui.open()
    end
    -- dap.listeners.before.event_terminated.dapui_config = function()
    --   ui.close()
    -- end
    -- dap.listeners.before.event_exited.dapui_config = function()
    --   ui.close()
    -- end
  end,
}
