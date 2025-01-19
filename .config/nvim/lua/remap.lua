vim.g.mapleader = " "

-- Random stuff
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Q" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })
-- Maybe redundant given the formatting that happens on save.
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format current buffer" })
-- TODO: Try out oil.nvim or some other file tree browswer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open File Browser" })

-- Movement and scrolling
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join next line with current line" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set({ "n", "v" }, ">", ">gv", { desc = "Indent selection" })
vim.keymap.set({ "n", "v" }, "<", "<gv", { desc = "Dedent selection" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down keep centering" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up keep centering" })
vim.keymap.set("n", "{", "{zz", { desc = "Scroll up a paragraph keep centering" })
vim.keymap.set("n", "}", "}zz", { desc = "Scroll down a paragraph keep centering" })
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>", { desc = "Move to the pane above" })
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>", { desc = "Move to the pane below" })
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>", { desc = "Move to the pane on the left" })
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>", { desc = "Move to the pane on the right" })

-- Searching
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result keep centering" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result keep centering" })
vim.keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Find and replace word under the cursor" }
)

-- Copy, Paste, Replace
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank to neovim registers" })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Replace selection with whatever has been yanked" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete selection and send it to the void" })
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
