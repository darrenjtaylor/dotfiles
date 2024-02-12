return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig"
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "tsserver",
                "pyright",
                "marksman"
            }
        })

        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup({
            capabilities = capabilities
        })
        lspconfig.tsserver.setup({
            capabilities = capabilities
        })
        lspconfig.pyright.setup({
            capabilities = capabilities
        })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
    end
}
