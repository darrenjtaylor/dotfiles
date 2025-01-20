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

		-- TODO: Need better keymaps for this.  Sticking to the number system, maybe
		-- it makes sense to have a dynamic keymap settings where it checks first if
		-- the UI has that number of files, and if it does, go to the given number,
		-- otherwise do nothing?
		vim.keymap.set("n", "<leader>1", function()
			ui.nav_file(1)
		end, { desc = "Harpoon: Jump to file 1" })
		vim.keymap.set("n", "<leader>2", function()
			ui.nav_file(2)
		end, { desc = "Harpoon: Jump to file 2" })
		vim.keymap.set("n", "<leader>3", function()
			ui.nav_file(3)
		end, { desc = "Harpoon: Jump to file 3" })
		vim.keymap.set("n", "<leader>4", function()
			ui.nav_file(4)
		end, { desc = "Harpoon: Jump to file 4" })
		vim.keymap.set("n", "<leader>5", function()
			ui.nav_file(5)
		end, { desc = "Harpoon: Jump to file 5" })
	end,
}
