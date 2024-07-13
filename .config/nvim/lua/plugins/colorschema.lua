return {
    "lewpoly/sherbet.nvim",
    lazy = false,
    name = "sherbet",
    priority = 1000,
    config = function()
        vim.cmd("colorscheme sherbet")
    end
}
