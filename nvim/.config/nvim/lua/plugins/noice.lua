return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("noice").setup({
			routes = {
				view = "cmdline",
				filter = {
					event = "msg_showmode",
				},
			},
		})
	end,
}
