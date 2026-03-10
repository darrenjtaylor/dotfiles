return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			direction = "float",
			float_opts = {
				border = "curved",
			},
		})

		local Terminal = require("toggleterm.terminal").Terminal

		local codex = Terminal:new({
			display_name = "codex",
			direction = "float",
			hidden = true,
		})

		function _codex_toggle()
			codex:toggle()
		end

		vim.keymap.set({ "n", "t" }, "<C-x>", "<cmd>lua _codex_toggle()<CR>", { noremap = true, silent = true })
	end,
}
