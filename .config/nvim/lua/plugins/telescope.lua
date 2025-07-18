return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	config = function()
		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		})
		local builtin = require("telescope.builtin")

		-- Search within files and buffers
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
		vim.keymap.set("n", "<leader>st", builtin.git_files, { desc = "[S]earch [T]racked" })
		vim.keymap.set("n", "<leader>sf", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end, { desc = "[S]earch [F]uzzy" })
		vim.keymap.set("n", "<leader>sc", function()
			builtin.live_grep({
				search_dirs = { vim.fn.stdpath("config") },
				additional_args = { "--type", "lua" },
				prompt_title = "Grep in Config > ",
			})
		end, { desc = "[S]earch [C]onfig" })
		vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })

		-- Search help docs and keymaps.
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
	end,
}
