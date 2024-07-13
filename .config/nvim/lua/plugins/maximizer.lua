return {
    "szw/vim-maximizer",
    config = function()
        vim.keymap.set("n", "<leader>m", ":MaximizerToggle<CR>")
        vim.keymap.set("v", "<leader>m", ":MaximizerToggle<CR>gv")
    end,
}
