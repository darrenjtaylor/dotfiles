return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"jay-babu/mason-null-ls.nvim",
	},
	config = function()
		require("mason-null-ls").setup({
			ensure_installed = {
				"ruff",
				"prettier",
				"shfmt",
				"stylua",
				"eslint_d",
			},
			automatic_installation = true,
		})

		local null_ls = require("null-ls")
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		local sources = {
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.prettier.with({ filetypes = { "json", "yaml", "markdown" } }),
			null_ls.builtins.formatting.shfmt,
			require("none-ls.formatting.ruff"),
			require("none-ls.formatting.ruff_format"),
			require("none-ls.diagnostics.eslint_d"),
		}

		null_ls.setup({
			sources = sources,
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
