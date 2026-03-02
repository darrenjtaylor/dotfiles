return {
	"christoomey/vim-tmux-navigator",
	vim.keymap.set("n", "C-h", ":TmuxNavigateLeft<CR>", { desc = "TMUX: Navigate to left pane" }),
	vim.keymap.set("n", "C-l", ":TmuxNavigateRightCR>", { desc = "TMUX: Navigate to right pane" }),
	vim.keymap.set("n", "C-k", ":TmuxNavigateUpCR>", { desc = "TMUX: Navigate to pane above" }),
	vim.keymap.set("n", "C-j", ":TmuxNavigateDown<CR>", { desc = "TMUX: Navigate to pane below" }),
}
