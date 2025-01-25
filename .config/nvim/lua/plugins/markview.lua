return {
	"OXY2DEV/markview.nvim",
	lazy = false, -- Don't change this, the plugin is already lazy loaded.
	config = function()
		require("markview").setup({})

		-- Setup and configure some extra functionality to make editing markdown
		-- files from normal and visual mode more straight forward:
		--
		--  1. `checkboxes` allows you to `toggle` or `change` the state of checkboxes.
		--  2. `headings` allows you to `increase` or `decrease` the heading size.
		--  3. `editor` makes it easier to `create` and `edit` code blocks.
		require("markview.extras.checkboxes").setup({})

		vim.keymap.set(
			{ "n", "v" },
			"<leader><leader>x",
			":Checkbox toggle<CR>",
			{ desc = "Toggle checkbox in markdown files" }
		)
		-- This can toggle different styles and states of the checkbox if you
		-- want to get crazy, but I don't really have a use case for it at the
		-- moment so I'm not going to setup a keymap for it.
		-- :Checkbox change x y
		--
		-- You can also do interactive mode to use `h`, `j`, `k`, `l` to change
		-- the state.  Again, I don't have a use case for anything other than
		-- simply toggling it as checked / unchecked, so I'm not creating a
		-- keymap for it.
		-- :Checkbox interactive

		require("markview.extras.headings").setup({})

		-- Note: These don't support visual mode since it's based on treesitter
		-- text objects.
		vim.keymap.set("n", "<leader><leader>i", ":Heading increase<CR>", { desc = "Increase markdown heading depth" })
		vim.keymap.set("n", "<leader><leader>d", ":Heading decrease<CR>", { desc = "Increase markdown heading depth" })

		require("markview.extras.editor").setup({})

		-- Note: This is sometimes finicky when setting the language of the
		-- code block because it attaches another LSP to the little buffer
		-- window you write the codeblock in.  There might be some settings
		-- that make this experience better, but currently it's not very well
		-- documented and I don't have the time to dig into the module to see
		-- what I can / cannot change.
		vim.keymap.set({ "n", "v" }, "<leader><leader>c", ":CodeCreate<CR>", { desc = "Create a markdown code block" })
		vim.keymap.set({ "n", "v" }, "<leader><leader>e", ":CodeEdit<CR>", { desc = "Edit a markdown code block" })
	end,
}
