return {
    "mistricky/codesnap.nvim",
    build = "make",
    keys = {
        { "<leader><leader>s", "<cmd>CodeSnapSave<cr>", mode = "v", desc = "Save a code snapshot to file" }
    },
    opts = {
        border = "rounded",
        has_breadcrumbs = true,
        has_line_number = true,
        watermark = ""
    },
}
