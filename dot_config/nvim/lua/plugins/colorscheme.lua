return {
	-- add catppuccin
	{ "catppuccin/nvim" },
	-- Configure LazyVim to use catppuccin them
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "catppuccin",
		},
	},
}
