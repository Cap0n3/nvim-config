-- Telescope is a fuzzy finder for Neovim that enables fast file and buffer navigation.

return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	keys = {
		{
			"<leader>ff",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Find files",
		},
		{
			"<leader>fb",
			function()
				require("telescope.builtin").buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>fs",
			function()
				require("telescope.builtin").lsp_document_symbols()
			end,
			desc = "Document symbols",
		},
		{
			"<leader>fm",
			function()
				require("telescope.builtin").lsp_document_symbols({
					symbols = { "class", "function", "method" },
				})
			end,
			desc = "Functions, methods & classes",
		},
		{
			"<leader>fS",
			function()
				require("telescope.builtin").lsp_workspace_symbols()
			end,
			desc = "Workspace symbols",
		},
	},
	config = function()
		-- Load Telescope core module
		local telescope = require("telescope")

		-- Main Telescope configuration
		telescope.setup({

			-- Global defaults for all pickers
			defaults = {
				-- Enable borders around Telescope windows
				border = true,

				-- Characters used to draw borders
				borderchars = {
					prompt = { " ", " ", "─", "│", "│", " ", "─", "└" },
					results = { "─", " ", " ", "│", "┌", "─", " ", "│" },
					preview = { "─", "│", "─", "│", "┬", "┐", "┘", "┴" },
				},
			},

			-- Picker-specific configuration
			pickers = {
				lsp_document_symbols = {
					sorting_strategy = "ascending",
					symbol_width = 50,
				},
				lsp_workspace_symbols = {
					sorting_strategy = "ascending",
					symbol_width = 50,
				},
				find_files = {
					-- Show hidden files (dotfiles)
					hidden = true,

					-- Use ripgrep to list files instead of default finder
					find_command = {
						"rg",
						"--files",
						-- Ignore common heavy or irrelevant directories
						"--glob",
						"!{.git/*,.next/*,.svelte-kit/*,target/*,node_modules/*}",
					},
				},
			},

			-- Configuration for Telescope extensions
			extensions = {
				fzf = {
					-- Enable fuzzy matching
					fuzzy = true,

					-- Replace Telescope’s default sorters with fzf
					-- fzf is faster + smarter results, especially in big projects.
					override_generic_sorter = true,
					override_file_sorter = true,

					-- Case-insensitive unless uppercase is used
					case_mode = "smart_case",
				},
			},
		})

		-- Load the fzf extension so Telescope actually uses it
		telescope.load_extension("fzf")
	end,
}
