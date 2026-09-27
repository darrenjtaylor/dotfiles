return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "rcarriga/nvim-dap-ui",
        "mfussenegger/nvim-dap-python",
        "leoluz/nvim-dap-go",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()
        -- Setup debug adapters per language here.

        -- TODO: Need to figure out where the venv for debugpy is and pass it in to the setup
        -- local dappy = require('dap-python')
        -- dappy.setup('~/.virtualenvs/debugpy/bin/python')
        -- dappy.resolve_python = function()
        --     return "/path/to/python"
        -- end

        require("dap-go").setup()

        -- Rust / C / C++ via codelldb (`:Mason` package "codelldb", or system install).
        local mason_codelldb = vim.fn.stdpath("data") .. "/mason/bin/codelldb"
        local codelldb_path = vim.fn.executable(mason_codelldb) == 1 and mason_codelldb
            or vim.fn.exepath("codelldb")
        dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = codelldb_path,
                args = { "--port", "${port}" },
            },
        }
        dap.configurations.rust = {
            {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
            },
        }

        dap.listeners.before.attach.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {})
        vim.keymap.set("n", "<leader>dc", dap.continue, {})
    end,
}
