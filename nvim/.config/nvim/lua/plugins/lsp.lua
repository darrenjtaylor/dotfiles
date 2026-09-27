return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Manual installer UI only (`:Mason`). No auto-install: servers and
		-- tools are expected on PATH (system package manager, rustup, go, npm, ...).
		{ "mason-org/mason.nvim", opts = {} },
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		require("mason").setup()

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		-- Replaces the old `on_attach(client, bufnr)` wired through mason-lspconfig handlers.
		local attach_group = vim.api.nvim_create_augroup("native-lsp-attach", { clear = true })
		vim.api.nvim_create_autocmd("LspAttach", {
			group = attach_group,
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				local bufnr = args.buf
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
				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
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
			end,
		})

		-- Enable and configure language servers (native 0.11+ API).
		--
		-- Servers must be installed outside Mason auto-install, e.g.:
		--   lua_ls / stylua   : Mason, brew, or `luarocks`
		--   marksman          : Mason, brew, or `cargo install marksman`
		--   pyright           : Mason or `npm i -g pyright`
		--   ts_ls + vue plugin: Mason (`vue-language-server`), or npm
		--   rust_analyzer + rustfmt/clippy: `rustup component add rust-analyzer rustfmt clippy`
		--   gopls/goimports/gofumpt/delve/golangci-lint: `go install ...` or Mason
		--
		-- Keys include:
		--    - cmd (table): Override the default command used to start the server
		--    - filetypes (table): Override the default list of associated filetypes for the server
		--    - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
		--    - settings (table): Override the default settings passed when initializing the server.
		--
		-- For example, to see the options for `lua_ls`, check out https://luals.github.io/wiki/settings/
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
							-- Present when `vue-language-server` is installed via `:Mason`;
							-- adjust if you manage it via npm instead.
							location = vim.fn.stdpath("data")
								.. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
							languages = { "vue" },
						},
					},
				},
			},
			-- Rust setup (linting via clippy is enabled in settings below)
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						cargo = { allFeatures = true },
						check = { command = "clippy" },
					},
				},
			},

			-- Go setup
			gopls = {
				settings = {
					gopls = {
						analyses = { unusedparams = true },
						staticcheck = true,
						gofumpt = true,
					},
				},
			},
		}

		for name, cfg in pairs(servers) do
			cfg.capabilities = vim.tbl_deep_extend("force", {}, capabilities, cfg.capabilities or {})
			vim.lsp.config(name, cfg)
		end
		vim.lsp.enable(vim.tbl_keys(servers))
	end,
}
