return {
	"simrat39/symbols-outline.nvim",
	config = function()
		require("symbols-outline").setup({
			autofold_depth = 0,
		})
		vim.keymap.set({ "n", "v" }, "<leader>ts", "<cmd>SymbolsOutline<CR>", { desc = "[T]oggle [S]ymbol Outline" })
	end,
}
