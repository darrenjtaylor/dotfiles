return {
	"kylechui/nvim-surround",
	version = "*",
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({
			-- Default keymaps to add, delete and change surrounding quotes,
			-- brackets and braces.
			--
			-- keymaps = {
			--     insert = "<C-g>s",
			-- 	   insert_line = "<C-g>S",
			-- 	   normal = "ys",
			-- 	   normal_cur = "yss",
			-- 	   normal_line = "yS",
			-- 	   normal_cur_line = "ySS",
			-- 	   visual = "S",
			-- 	   visual_line = "gS",
			-- 	   delete = "ds",
			-- 	   change = "cs",
			-- 	   change_line = "cS",
			-- },
			--
			-- Default aliases for brackets, braces and quotes.
			--
			-- aliases = {
			--     ["a"] = ">",
			--     ["b"] = ")",
			--     ["B"] = "}",
			--     ["r"] = "]",
			--     ["q"] = { '"', "'", "`" },
			--     ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
			-- },
		})
	end,
}
