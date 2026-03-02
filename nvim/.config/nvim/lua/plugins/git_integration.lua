return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup()
		vim.keymap.set("n", "<leader>b", ":Gitsigns blame<CR>", { desc = "[G]it [B]lame" })
	end,
}
