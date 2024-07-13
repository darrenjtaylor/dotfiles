return {
    "christoomey/vim-tmux-navigator",
    vim.keymap.set("n", "C-h", ":TmuxNavigateLeft<CR>"),
    vim.keymap.set("n", "C-l", ":TmuxNavigateRightCR>"),
    vim.keymap.set("n", "C-k", ":TmuxNavigateUpCR>"),
    vim.keymap.set("n", "C-j", ":TmuxNavigateDown<CR>"),
}
