-- Syntax highlighting, indentation, code navigation plugin --

return {
	-- Treesitter plugin for advanced syntax highlighting, indentation, and code navigation
	"nvim-treesitter/nvim-treesitter",

	-- Automatically update parsers when the plugin is updated
	build = ":TSUpdate",

	-- Required for textobject motions (]f, ]c, ]a, etc.)
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},

	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			-- List of language parsers to install
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"diff",
				"go",
				"gomod",
				"gosum",
				"gotmpl",
				"html",
				"htmldjango",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"printf",
				"python",
				"query",
				"regex",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			},

			-- Don't install parsers synchronously (faster startup)
			sync_install = false,

			-- Enable syntax highlighting
			highlight = { enable = true },

			-- Enable better indentation
			indent = { enable = true },

			-- Enable incremental selection (expand/shrink selection by syntax nodes)
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>", -- Start selection
					node_incremental = "<C-space>", -- Expand to next node
					scope_incremental = false, -- Disabled: expand to scope
					node_decremental = "<bs>", -- Shrink to previous node
				},
			},

			-- Enable text objects (navigation based on syntax tree)
			textobjects = {
				move = {
					enable = true,
					-- Move to the start of the next X
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]a"] = "@parameter.inner",
					},
					-- Move to the end of the next X
					goto_next_end = {
						["]F"] = "@function.outer",
						["]C"] = "@class.outer",
						["]A"] = "@parameter.inner",
					},
					-- Move to the start of the previous X
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
						["[a"] = "@parameter.inner",
					},
					-- Move to the end of the previous X
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
						["[A"] = "@parameter.inner",
					},
				},
			},
		})
	end,
}
