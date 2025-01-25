return {
	"ThePrimeagen/harpoon",
	config = function()
		require("harpoon").setup({
			tabline = true,
		})
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon: [A]dd file to harpoon list" })
		vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Harpoon: [E]dit harpoon list" })

		-- Maybe a better way to do this, but for now just create keymaps for
		-- files 1-9.
		for num = 1, 9 do
			vim.keymap.set("n", "<leader>" .. num, function()
				ui.nav_file(num)
			end, { desc = "Harpoon: Jump to file " .. num })
		end
	end,
}
