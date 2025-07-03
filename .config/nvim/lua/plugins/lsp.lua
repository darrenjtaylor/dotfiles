return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local on_attach = function(client, bufnr)
			local ts_builtin = require("telescope.builtin")

			local map = function(keys, func, desc, mode)
				mode = mode or "n"
				vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
			end

			-- Buffer local mappings
			map("gd", ts_builtin.lsp_definitions, "[G]oto [D]efinition")
			map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
			map("gr", ts_builtin.lsp_references, "[G]et [R]eferences")
			map("K", vim.lsp.buf.hover, "Show signature details")
			map("gI", ts_builtin.lsp_implementations, "[G]oto [I]mplementations")
			map("<leader>D", ts_builtin.lsp_type_definitions, "Type [D]efinition")
			map("<leader>ds", ts_builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
			map("<leader>ws", ts_builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
			map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
			map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "v" })
			map("<leader>td", function()
				vim.diagnostic.open_float()
			end, "[T]oggle [D]iagnostics")

			-- Autocommands to highlight words under the cursor
			if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
				local highlight_augroup_name = "lsp-highlighting-" .. bufnr
				vim.api.nvim_create_augroup(highlight_augroup_name, { clear = true })

				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = bufnr,
					group = highlight_augroup_name,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = bufnr,
					group = highlight_augroup_name,
					callback = vim.lsp.buf.clear_references,
				})

				vim.api.nvim_create_autocmd("LspDetach", {
					group = vim.api.nvim_create_augroup("lsp-detach-" .. bufnr, { clear = true }),
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.clear_references()
						vim.api.nvim_del_augroup_by_name(highlight_augroup_name)
					end,
				})
			end
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		-- Enable and configure language servers.
		--
		--  Add language servers here and it will automatically be installed.
		--  Keys include:
		--    - cmd (table): Override the default command used to start the server
		--    - filetypes (table): Override the default list of associated filetypes for the server
		--    - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
		--    - settings (table): Override the default settings passed when initializing the server.
		--
		--  For example, to see the options for `lua_ls`, check out https://luals.github.io/wiki/settings/
		local servers = {
			-- Lua setup
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						diagnostics = {
							disable = { "missing-fields" },
						},
					},
				},
			},

			-- Markdown setup
			marksman = {},

			-- Python setup
			pyright = {},

			-- Typescript setup
			ts_ls = {
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = vim.fn.stdpath("data")
								.. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
							languages = { "vue" },
						},
					},
				},
			},
		}

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"black",
			"eslint_d",
			"flake8",
			"prettier",
			"stylua",
			"sqlfmt",
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					server.on_attach = on_attach
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
