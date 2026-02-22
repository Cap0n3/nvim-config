-- LSP configuration --

return {
	"neovim/nvim-lspconfig",
	version = "v2.*",

	event = { "BufReadPre", "BufNewFile" },

	dependencies = {
		"mason-org/mason.nvim",
		{ "mason-org/mason-lspconfig.nvim", version = "v1.*" },
	},

	config = function()
		-- Get completion capabilities from cmp
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
		if ok then
			capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
		end

		-- LSP keymaps on attach
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
			callback = function(ev)
				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			end,
		})

		-- Set up mason-lspconfig with auto-installed servers
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"pyright",
				"ts_ls",
				"clangd",
				"html",
				"cssls",
				"jsonls",
				"yamlls",
				"bashls",
			},
			handlers = {
				-- Default handler: set up all servers with shared capabilities
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
				-- Override for lua_ls: add Neovim runtime awareness
				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								runtime = { version = "LuaJIT" },
								workspace = {
									checkThirdParty = false,
									library = { vim.env.VIMRUNTIME },
								},
							},
						},
					})
				end,
			},
		})
	end,
}
