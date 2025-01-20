return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- Set LSP related keymaps when an LSP server is attached to a buffer.
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local ts_builtin = require("telescope.builtin")

				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
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
					vim.diagnostic.enable(not vim.diagnostic.is_enabled())
				end, "[T]oggle [D]iagnostics")

				-- Autocommands to highlight words under the cursor
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlighting", { clear = false })

					-- Highlight other references of the word under the cursor
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = ev.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					-- Clear any highlights as soon as the cursor is moved somewhere else
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = ev.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					-- Clear references and autocommands on detach
					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
						callback = function(inner_event)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "lsp-highlighting", buffer = inner_event.buf })
						end,
					})
				end
			end,
		})

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
			ts_ls = {},
		}

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"eslint_d",
			"prettier",
			"ruff",
			"stylua",
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
