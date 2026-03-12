-- LSP configuration --

return {
	"neovim/nvim-lspconfig",

	event = { "BufReadPre", "BufNewFile" },

	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
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

		-- Configure individual servers using the new API
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		vim.lsp.config("lua_ls", {
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

		-- mason-lspconfig v2 just handles ensure_installed
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
				"gopls",
			},
		})

		-- Enable all servers
		vim.lsp.enable({
			"lua_ls",
			"pyright",
			"ts_ls",
			"clangd",
			"html",
			"cssls",
			"jsonls",
			"yamlls",
			"bashls",
			"gopls",
		})
	end,
}
