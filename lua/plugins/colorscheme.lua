-- Colorscheme plugin --

return {
	"ellisonleao/gruvbox.nvim",

	priority = 1000, -- Load first to avoid flicker
	config = function()
		-- Activate color in terminal
		vim.opt.termguicolors = true

		-- Apply theme
		vim.cmd.colorscheme("gruvbox")
	end,
}
