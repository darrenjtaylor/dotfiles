return {
	{
		"lewpoly/sherbet.nvim",
		lazy = false,
		name = "sherbet",
		priority = 1000,
		enabled = false,
		config = function()
			vim.cmd("colorscheme sherbet")
		end,
	},
	{
		"sho-87/kanagawa-paper.nvim",
		lazy = false,
		name = "kanagawa-paper",
		priority = 1000,
		config = function()
			vim.cmd("colorscheme kanagawa-paper")
		end,
	},
}
