return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
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
		vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
		vim.keymap.set("n", "<C-p>", builtin.git_files, {})
		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
		vim.keymap.set("n", "<leader>pb", builtin.buffers, {})

        -- Search help docs.
		vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})

        -- Search variables / functions / types, in current buffer
        vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, {})

        -- Search variables / functions / types, in your entire workspace
        vim.keymap.set("n", "<leader>ws", builtin.lsp_dynamic_workspace_symbols, {})
	end,
}
