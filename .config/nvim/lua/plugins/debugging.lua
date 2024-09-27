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
