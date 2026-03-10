return {
	"hedyhli/outline.nvim",
	config = function()
		require("outline").setup({
			symbol_folding = {
				autofold_depth = 1,
				auto_unfold = {
					hovered = true,
				},
			},
		})
		vim.keymap.set({ "n", "v" }, "<leader>ts", "<cmd>Outline<CR>", { desc = "[T]oggle [S]ymbol Outline" })
	end,
}
